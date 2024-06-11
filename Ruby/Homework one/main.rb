require_relative 'module/Store'
require_relative 'module/Customer'
require_relative 'module/Admin'

$store = Store.new()
$basket = Customer.new()
    puts "Добро пожаловать в магазин дисков!"
loop do
    puts "\nВыберите действие:\n1. Просмотр товаров\n2. Добавить товар в корзину\n3. Просмотреть корзину\n4. Получить итоговую сумму заказа\n5. Административные функции\n6. Выйти\n\nВведите номер действия:"

    user_choice = gets.chomp.to_i   
    case user_choice
    when 1
        $store = Store.new()
        $store.display_items
        $basket = Customer.new()
    when 2
        $store.display_items
        puts "Введите нужную цифру для добавления товара в корзину"
        count = 0
        quantity = $store.quantity_items
        mass = []
        while count <= quantity
            items_choice = gets.chomp.to_i
            mass << items_choice
            puts "\nДобавить еще? 1 - Да. 0 - Нет"
            choice = gets.chomp.to_i
            if choice == 0
                break mass
            end
            count += 1
        end
        user_basket = $basket.record_basket_user(mass)
    when 3
        final_basket = $basket.view_cart
        final_basket.map.with_index(1) { |item, index| puts "#{index}. #{item['type']} - #{item['title']} - #{item['price']}"}
    when 4
        summ = $basket.view_final_price
        puts "Итоговая сумма вашей корзины #{summ} рублей"
    when 5
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
                choice_year = gets.chomp.to_i
                puts "Кто создатель товара?"
                choice_director = gets.chomp.to_s
                puts "Какая цена за товар"
                choice_price = gets.chomp.to_i
                puts "Количество данного товара"
                choice_quantity = gets.chomp.to_i
                admin_basket = Admin.new()
                admin_basket.add_item(choice_type, choice_title, choice_year, choice_director, choice_price, choice_quantity)
                
            when 2
                break
            else
                break
            end
        end
    when 6
        "До свидания!"
        break
    else
        "Введите нужный номер"
    end
end