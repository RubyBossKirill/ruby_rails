require_relative 'Store'

class Customer < Store
    def initialize
        super
        @user_basket = []
    end

    def record_basket_user(user_basket)
        @user_basket = user_basket
    end

    def record_basket(name, type)
        result = search_for_name_db(name, type)
        @user_basket = @user_basket << result[0]
        p @user_basket
    end

    def view_cart
        user_basket_final = @user_basket.map { |file_id| file_id }
    end

    def view_final_price
        view_final_price = @user_basket.map { |file_id| @books[Store::VARIABLE_HASH][file_id - 1] }
        view_final_price.sum { |item| item['price'] }
    end
end