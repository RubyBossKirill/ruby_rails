require 'json'

class Store
    JSON_DATA = 'lib/books.json'
    attr_accessor :books

    def initialize()
        @books = load_items_from_json
    end

    def display_items
        @books['items'].map.with_index(1) { |item, index| puts "#{index}. #{item['type']} - #{item['title']} - #{item['price']}"}
    end
    
    def quantity_items
        @books['items'].count
    end

    def check_index(index)
        index = index.to_i - 1
        @books['items'][index]
    end
    

    protected
    def load_items_from_json
        file = File.read(JSON_DATA)
        data_books = JSON.parse(file)
    end

    def save_items_to_json(data)
        file = File.read(JSON_DATA)
        read = JSON.parse(file)
        base = read
        base['items'] << data
        File.open(JSON_DATA, 'w') do |file|
            file.write(base.to_json) 
        end
        @books = base
    end
end


