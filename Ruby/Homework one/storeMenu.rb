require_relative 'module/Store'
require_relative 'module/Customer'
require_relative 'module/Admin'
require_relative 'module/auth'
require_relative 'module/Database'

puts "Приветствую. Авторизуйтесь или зарегистрируйтесь в нашем магазине."
user_sing_up = nil
store = Store.new()
basket = Customer.new()
# общий луп, со всем меню
catch :exit_loops do
    loop do
        # луп по авторизации. В данном лупе клиент выбирает войти или зарегаться, 
        # или вовсе выйти
        loop do
            puts "Выберите нужную цифру:\n1. Войти \n2. Зарегистрироваться\n3. Выйти"
            choice = gets.chomp.to_i
            case choice
            when 1
                # тут луп для того, чтобы клиент ввел мэло и пароль
                loop do
                    puts "Введите Email"
                    user_email = gets.chomp

                    puts "Введите пароль"
                    user_password = gets.chomp
                    # после ввода логина и пароля, мы создаем экземпляр класса,
                    # в котором передаем то что он ввел и проверяем есть такой клиент или нет
                    user_sing_up = Authentication::UserAuth.new(user_email, user_password)
                    # если клиент имеется, то вход успешный и двигаемся дальше. Если нет, то 
                    # предлагаем заново ввести логин и пароль
                    if user_sing_up.user_auth == true
                        break puts "\nВход успешен, приветствую #{user_sing_up.login}\n"
                    else
                        puts "\nНеверный логин или пароль\n"
                    end
                end
                break
            # если клиент выбрал зарегистрироваться
            when 2
                puts 'Рады будем видеть в наших рядах'
                puts 'Введите email'
                count = 0
                email = gets.chomp
                # тут мы запрашиваем емаил, после чего проверяем его валидность
                # если он ен валиден, то мы говорим ему еще раз ввести его
                # дается 3 попытки. После чего программа выкинет его
                while count < 3 do
                    # тут мы обращаемся к селф методу в auth.rb
                    if Authentication::UserAuth.valid_email?(email) == true
                        break
                    else
                        count += 1
                        p "Попробуйте еще раз ввести email"
                        email = gets.chomp
                    end
                end
                # здесь, если человек после 3 попыток не получилось пройти валидацию
                # то мы пишем что попыток исчерпано и выкидываем из программы
                if Authentication::UserAuth.valid_email?(email) == false
                    break p "Количество попыток исчерпано. Запустите программу заново"
                end

                # дальше идем к логину. Запрашиваем логин, без валидации. Просто логин
                puts "Придумайте логин"
                login = gets.chomp.to_s

                # дальше мы запрашиваем пароль и отправляем на валидацию. Так же как и мыло
                puts "Напишите пароль. Минимум 8 символов"
                password = gets.chomp
                count = 0
                while count < 3 do
                    #  # тут мы обращаемся к селф методу в auth.rb
                    if Authentication::UserAuth.valid_password?(password) == true
                        break
                    else
                        count += 1
                        p "Придумайте другой пароль. Посложнее. Минимум 8 символов"
                        password = gets.chomp
                    end
                end
                
                # здесь, если человек после 3 попыток не получилось пройти валидацию
                # то мы пишем что попыток исчерпано и выкидываем из программы
                if Authentication::UserAuth.valid_password?(password) == false
                    break p "Количество попыток исчерпано. Запустите программу заново"
                end
                # тут мы проводим регистрацию с записью в БД
                user = Authentication::UserAuth.new(email, login, password)
                user.registered

                puts "Поздравляю с регистрацией."
                return user
            when 3
                puts "До свидания!"
                throw :exit_loops
            else
                puts "Введите нужную цирфу"
            end
        end
        
        puts "\nДобро пожаловать в магазин дисков!"
        # тут все что связано с меню уже
        loop do
            puts "\nВыберите действие:\n1. Просмотр товаров\n2. Добавить товар в корзину"
            puts "3. Просмотреть корзину\n4. Получить итоговую сумму заказа\n5. Поиск товара"
            puts "6. Административные функции\n7. Выйти\n\nВведите номер действия:"
            user_choice = gets.chomp.to_i   
            case user_choice
            when 1 # просмотр товаров
                store.display_items
            when 2 # Добавить товар в корзину
                store.display_items
                puts "Введите нужную цифру для добавления товара в корзину"
                count = 0
                quantity = store.quantity_items
                mass = []
                while count <= quantity
                    items_choice = gets.chomp.to_i
                    mass << store.view_product(items_choice - 1, 'id')[0]
                    puts "\nДобавить еще? 1 - Да. 0 - Нет"
                    choice = gets.chomp.to_i
                    if choice == 0
                        break mass
                    end
                    count += 1
                end
                user_basket = basket.record_basket_user(mass)
            when 3 # Просмотреть корзину
                final_basket = basket.view_cart
                final_basket.map.with_index(1) { |item, index| puts "#{index}. #{item['type']} - #{item['title']} - #{item['price']}"}
            when 4 # Получить итоговую сумму заказа
                summ = basket.view_final_price
                puts "Итоговая сумма вашей корзины #{summ} рублей"
            when 5 # поиск товара
                loop do
                    puts "Выбери какой поиск хотите осуществить:"
                    puts "1. Поиск товаров по имени\n2. Поиск товара по исполнителю"
                    puts "3. Поиск товаров по типу\n4. Выйти в меню"
                    user_choice = gets.chomp.to_i
                    value = nil
                    if user_choice == 1
                        value = "title"
                    elsif user_choice == 2
                        value = "director"
                    elsif user_choice == 3
                        value = "type"
                    else
                        break
                    end
                    list = store.search_product("#{value}")
                    puts "Доступные значения для поиска:"
                    list.each_with_index {|title, index| puts "#{index}. #{title}" }
                    puts "Напишите нужное значение"
                    user_choice_value = gets.chomp.to_s
                    list = store.view_product(user_choice_value, "#{value}")
                    if list == [] || list == nil
                        puts "Попробуй другое значение. По такому имени не найден ничего"
                    else
                        puts "Вот что нашлось:"
                        list.each_with_index {|title, index| puts "#{title['type']} - #{title['title']} - #{title['year']} - #{title['director']} - #{title['price']} рублей." }
                        puts "Это ваша книга?\n1. Да\n2. Нет"
                        user_choice = gets.chomp.to_i
                        if user_choice == 1
                            puts "Добавили в вашу корзину"
                            basket.record_basket(user_choice_value, "#{value}")
                        end
                    end
                end
            when 6 # Административные функции
                if user_sing_up.member == 'admin'
                    loop do
                        puts "Административные функции:\n1. Добавить новый товар\n2. Вернуться назад\nВведите номер действия:"
                        choice = gets.chomp.to_i
                        case choice
                        when 1
                            puts "Введите тип товара:"
                            choice_type = gets.chomp.to_s
                            puts "Введите название товара:"
                            choice_title = gets.chomp.to_s
                            puts "Введите год выпуска:"
                            choice_year = nil
                            loop do
                                choice_year = gets.chomp.to_i
                                if choice_year.is_a?(Integer) && choice_year != 0
                                    break
                                else
                                    p 'Введите число. Например: 2000'
                                end
                            end
                            puts "Кто создатель товара?"
                            choice_director = gets.chomp.to_s
                            puts "Какая цена за товар"
                            choice_price = nil
                            loop do
                                choice_price = gets.chomp.to_i
                                if choice_price.is_a?(Integer) && choice_price != 0
                                    break
                                else
                                    p 'Введите число. Например: 1000'
                                end
                            end
                            puts "Количество данного товара"
                            choice_quantity = nil
                            loop do
                                choice_quantity = gets.chomp.to_i
                                if choice_quantity.is_a?(Integer) && choice_quantity != 0
                                    break
                                else
                                    p 'Введите число. Например: 10'
                                end
                            end
                            admin_basket = Admin.new()
                            admin_basket.add_item(choice_type, choice_title, choice_year, choice_director, choice_price, choice_quantity)
                        when 2
                            break
                        else
                            break
                        end
                    end
                else
                    puts 'Вы не администратор!'
                end
            when 7 # Выйти
                puts "До свидания!"
                throw :exit_loops
            else
                "Введите нужный номер"
            end
        end
        throw :exit_loops
    end
end