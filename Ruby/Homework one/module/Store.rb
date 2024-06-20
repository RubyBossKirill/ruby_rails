

class Store
    VARIABLE_HASH = 'items'
    DB_NAME_STORE = 'store_products'
    attr_accessor :books

    def initialize
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
        search_for_name_db(name, value)
    end

    protected
    
    def load_from_db
        db = Database.new
        db.execute("SELECT * FROM #{DB_NAME_STORE}")
    end

    def save_to_db(hash)
        db = Database.new

        columns = hash.keys.join(',')
        placeholders = ('?,' * hash.keys.size).chomp(',')
        query = "INSERT INTO #{DB_NAME_STORE} (#{columns}) VALUES (#{placeholders})"
        
        db.execute(query, hash.values)
    end
    
    def search_for_name_db(name, type)
        db = SQLite3::Database.open(@@DATABASE)
        db.results_as_hash = true

        db_result = db.execute("SELECT * FROM #{@@DATABASE_NAME} WHERE #{type} = ?", name)

        db.close
        return db_result
    end
end
