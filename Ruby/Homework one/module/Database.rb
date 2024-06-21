require 'sqlite3'
class Database

    DB_FILE_STORE = "database/store_products.sqlite"
    
    def initialize
        @db = SQLite3::Database.open(DB_FILE_STORE)
        @db.results_as_hash = true
    end

    def execute(query, *params)
        @db.execute(query, *params)
    end
    
    def store_insert_into(hash)
        columns = hash.keys.join(',')
        placeholders = ('?,' * hash.keys.size).chomp(',')
        query = "INSERT INTO store_products (#{columns}) VALUES (#{placeholders})"
        execute(query, hash.values)
    end

    def store_search_position(name, type)
        query = "SELECT * FROM store_products WHERE #{type} = ?"
        execute(query, name)
    end
end