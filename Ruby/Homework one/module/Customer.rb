require_relative 'Store'

class Customer
    def initialize(data)
        @store_list = data
        @user_basket = nil
    end

    def record_basket_user(user_basket)
        @user_basket = user_basket
    end

end