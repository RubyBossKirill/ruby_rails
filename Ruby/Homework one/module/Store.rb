require 'json'

class Store
    JSON_DATA = 'lib/books.json'

    def initialize()
        @books = load_items_from_json
    end

    def display_items
        numb = 0
        @books['items'].each {|item| p "#{numb += 1}. #{item['type']} - #{item['title']} - #{item['price']}"} 
    end

    def quantity_items
        @books['items'].count
    end

    def check_index(index)
        @books['items'][index]
    end

    def admin_item_add(hash)
        @books['items']
        @books['items'] << hash
        save_items_to_json(@books)
    end

    private
    def load_items_from_json
        file = File.read(JSON_DATA)
        data_books = JSON.parse(file)
    end

    def save_items_to_json(data)
        file = File.read(JSON_DATA)
        read = JSON.parse(file)
        base = read
        base['items'] = data['items']
        File.open(JSON_DATA, 'w') do |file|
            file.write(base.to_json) 
        end
    end
end


