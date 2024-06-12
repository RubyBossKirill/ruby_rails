require 'sqlite3'

class Store

    VARIABLE_HASH = 'items'
    @@DATABASE = 'database/store_products.sqlite'
    attr_accessor :books

    def initialize
        @books[VARIABLE_HASH] = load_from_db
    end

    def display_items
        @books[VARIABLE_HASH].map.with_index(1) { |item, index| puts "#{index}. #{item['type']} - #{item['title']} - #{item['price']}"}
    end
    
    def quantity_items
        @books[VARIABLE_HASH].size
    end

    protected
    
    def load_from_db
        db = SQLite3::Database.open(@@DATABASE)
        db.results_as_hash = true

        rows = db.execute "SELECT * FROM store_products"
        
        db.close
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
end
