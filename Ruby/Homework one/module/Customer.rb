require_relative 'Store'

class Customer < Store
    def initialize
        super
        @user_basket = nil
    end

    def record_basket_user(user_basket)
        @user_basket = user_basket
    end

    def view_cart
        user_basket_final = @user_basket.map { |file_id| @books[Store::VARIABLE_HASH][file_id - 1] }
    end

    def view_final_price
        view_final_price = @user_basket.map { |file_id| @books[Store::VARIABLE_HASH][file_id - 1] }
        view_final_price.sum { |item| item['price'] }
    end
end