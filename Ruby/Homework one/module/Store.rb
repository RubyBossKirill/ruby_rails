

class Store
    VARIABLE_HASH = 'items'
    DB_NAME_STORE = 'store_products'
    attr_accessor :books

    def initialize
        @db = Database.new
        @books = {}
        @books[VARIABLE_HASH] = load_from_db
    end

    def display_items
        @books[VARIABLE_HASH].map.with_index(1) { |item, index| puts "#{index}. #{item['type']} - #{item['title']} - #{item['price']}"}
    end
    
    def quantity_items
        @books[VARIABLE_HASH].size
    end

    def search_product(value)
       @books[VARIABLE_HASH].map { |item| item[value] }.uniq
    end

    def view_product(name, value)
        search_name_in_db(name, value)
    end

    protected
    
    def load_from_db
        @db.execute("SELECT * FROM #{DB_NAME_STORE}")
    end

    def save_to_db(hash)
        @db.store_insert_into(hash)
    end
    
    def search_name_in_db(name, type)
        @db.store_search_position(name, type)
    end
end
