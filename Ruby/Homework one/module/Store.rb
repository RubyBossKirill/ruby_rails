require 'json'
require 'sqlite3'

class Store
    JSON_DATA = 'database/books.json'
    VARIABLE_HASH = 'items'
    @@DATABASE = 'database/store_products.sqlite'
    attr_accessor :books

    def initialize
        @books = load_items_from_json
    end

    def display_items
        @books[VARIABLE_HASH].map.with_index(1) { |item, index| puts "#{index}. #{item['type']} - #{item['title']} - #{item['price']}"}
    end
    
    def quantity_items
        @books[VARIABLE_HASH].size
    end

    protected

    # ВЫРЕЗАТЬ НАХРЕН 
    
    def load_items_from_json
        file = File.read(JSON_DATA)
        data_books = JSON.parse(file)
    end

    def save_items_to_json(data)
        @books[VARIABLE_HASH] << data
        File.open(JSON_DATA, 'w') do |file|
            file.write(@books.to_json) 
        end
    end

     # ВЫРЕЗАТЬ НАХРЕН 
    
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
start = Store.new()
start.load_from_db

