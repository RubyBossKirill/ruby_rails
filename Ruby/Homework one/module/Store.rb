require 'json'

class Store
    JSON_DATA = '../lib/books.json'

    def initialize()
    end

    def load_items_from_json
        file = File.read(JSON_DATA)
        data_books = JSON.parse(file)
    end

    def save_items_to_json(data)
        file = File.read(JSON_DATA)
        read = JSON.parse(file)
        base = read['items']
        base << data  
        read['items'] = base
        File.open(JSON_DATA, 'w') do |file|
            file.write(read.to_json) 
        end
    end
end


magaz = Store.new()
p magaz
label = magaz.load_items_from_json
p label['items'][1]['title']
data = {"type": "sadasdaf", "title": "Леон", "year": 1994, "director": "Люк Бессон", "price": 990, "quantity": 5}
magaz.save_items_to_json(data)