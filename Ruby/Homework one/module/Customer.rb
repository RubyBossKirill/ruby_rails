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
    end

    def view_cart
        user_basket_final = @user_basket.map { |file_id| file_id }
    end

    def view_final_price
        view_final_price = @user_basket.map { |file_id| file_id }
        view_final_price.sum { |item| item['price'] }
    end
end