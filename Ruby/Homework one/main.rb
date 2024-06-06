require_relative 'module/Store'
require_relative 'module/Customer'

$store = Store.new()
$basket = Customer.new($store)

    puts "Добро пожаловать в магазин дисков!"
loop do
    puts "\nВыберите действие:\n1. Просмотр товаров\n2. Добавить товар в корзину\n3. Просмотреть корзину\n4. Получить итоговую сумму заказа\n5. Административные функции\n6. Выйти\n\nВведите номер действия:"

    user_choice = gets.chomp.to_i   
    case user_choice
    when 1
        $store.display_items
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
        $user_basket = $basket.record_basket_user(mass)
    when 3
        $basket.view_cart
    when 4
        $basket.view_final_price
    when 5
        asdasd
    when 6
        "До свидания!"
        break
    else
        "Введите нужный номер"
    end
end