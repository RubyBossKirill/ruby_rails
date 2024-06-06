require_relative 'Store'

class Customer
    def initialize(data)
        @store_list = data
        @user_basket = nil
    end

    def record_basket_user(user_basket)
        @user_basket = user_basket
    end

    def view_cart
        count = 0
        user_basket_final = @user_basket.map { |file_id| @store_list.check_index(file_id) }
        user_basket_final.each {|item| puts "#{count += 1}. #{item['type']} - #{item['title']} - #{item['price']}"}
    end

    def view_final_price
        view_final_price = @user_basket.map { |file_id| @store_list.check_index(file_id) }
        count = 0
        summ = view_final_price.map {|item| item['price'] + count}
        puts "Итоговая сумма вашей корзины #{summ.sum} рублей"
    end
end