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
end