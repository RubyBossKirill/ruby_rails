
class Admin
    def initialize
        @admin_item = {
            :type => nil,
            :title => nil,
            :year => nil,
            :director => nil,
            :price => nil,
            :quantity => nil
        }
    end
    def add_item(type, title, year, director, price, quantity, store)
        @admin_item = {
            :type => type,
            :title => title,
            :year => year,
            :director => director,
            :price => price,
            :quantity => quantity
        }
        store.admin_item_add(@admin_item)
    end

end