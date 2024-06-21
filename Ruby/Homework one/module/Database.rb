require 'sqlite3'
class Database
    
    def initialize(file)
        @file = file
        @db = SQLite3::Database.open("database/#{file}.sqlite")
        @db.results_as_hash = true
    end

    def insert_into(hash)
        columns = hash.keys.join(',')
        placeholders = ('?,' * hash.keys.size).chomp(',')
        query = "INSERT INTO #{@file} (#{columns}) VALUES (#{placeholders})"
        execute(query, hash.values)
    end

    def search_position(name, type)
        query = "SELECT * FROM #{@file} WHERE #{type} = ?"
        execute(query, name)
    end

    def execute(query, *params)
        @db.execute(query, *params)
    end
end