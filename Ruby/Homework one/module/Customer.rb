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
        user_basket_final = @user_basket.map { |file_id| @store_list.check_index(file_id) }
    end

    def view_final_price
        view_final_price = @user_basket.map { |file_id| @store_list.check_index(file_id) }
        view_final_price.sum { |item| item['price'] }
    end
end