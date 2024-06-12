class Admin < Store

    def initialize
        super
        @admin_item = {
            "type" => nil,
            "title" => nil,
            "year" => nil,
            "director" => nil,
            "price" => nil,
            "quantity" => nil
        }
    end
    def add_item(type, title, year, director, price, quantity)
        @admin_item = {
            "type" => type,
            "title" => title,
            "year" => year,
            "director" => director,
            "price" => price,
            "quantity" => quantity
        }
        save_to_db(@admin_item)
    end

end