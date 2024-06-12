require 'sqlite3'

class Store
    VARIABLE_HASH = 'items'
    @@DATABASE = 'database/store_products.sqlite'
    @@DATABASE_NAME = 'store_products'
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
       list_type = @books[VARIABLE_HASH].map { |item| item[value] }.uniq
       return list_type
    end

    def view_product(name, value)
        result = search_for_name_db(name, value)
        p result
        return result
    end

    protected
    
    def load_from_db
        db = SQLite3::Database.open(@@DATABASE)
        db.results_as_hash = true

        rows = db.execute "SELECT * FROM store_products"

        db.close
        return rows
    end

    def save_to_db(hash)
        db = SQLite3::Database.open(@@DATABASE)
        db.results_as_hash = true

        db.execute <<-SQL
            CREATE TABLE IF NOT EXISTS store_products (
                id INTEGER PRIMARY KEY,
                type TEXT,
                title TEXT,
                year INTEGER,
                director TEXT,
                price INTEGER,
                quantity INTEGER
            );
        SQL

        db.execute(
            "INSERT INTO store_products (" +
                hash.keys.join(',') + ")" +
                "VALUES (" +
                ('?,'*hash.keys.size).chomp(',') +
                ")",
                hash.values
        )

        db.close
    end
    
    def search_for_name_db(name, type)
        db = SQLite3::Database.open(@@DATABASE)
        db.results_as_hash = true

        db_result = db.execute("SELECT * FROM #{@@DATABASE_NAME } WHERE #{type} = ?", name)

        db.close
        return db_result
    end
end
