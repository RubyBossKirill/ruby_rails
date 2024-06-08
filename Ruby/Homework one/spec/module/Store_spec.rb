RSpec.describe Store do
    let(:expected_books) { {"items":[{"type":"film","title":"Леон","year":1994,"director":"Люк Бессон","price":990,"quantity":5},{"type":"film","title":"Дурак","year":2014,"director":"Юрий Быков","price":390,"quantity":1},{"type":"book","title":"Идиот","author":"Федор Достоевский","price":1500,"quantity":10},{"type":"film","title":"Леон","year":1994,"director":"Люк Бессон","price":990,"quantity":5},{"type":"sadasdaf","title":"Леон","year":1994,"director":"Люк Бессон","price":990,"quantity":5},{"type":"books","title":"Gun Bitch","year":1999,"director":"Kir El","price":1099,"quantity":1},{"type":"types","title":"Ivan","year":1998,"director":"El kir","price":1000,"quantity":1},{"type":"film","title":"Kirill Muchenik","year":2024,"director":"Elin Kir","price":2000,"quantity":1},{"type":"dvcxvx","title":"dsgds","year":1233,"director":"sdgdf","price":2131,"quantity":1},{"type":"ljkdgslkd","title":"dgsdfg","year":1234,"director":"agdfgsd","price":24234,"quantity":1},{"type":"test","title":"test","year":1,"director":"test","price":1,"quantity":1},{"type":"test1","title":"test1","year":1,"director":"test","price":2,"quantity":2},{"type":"test3","title":"test3","year":3,"director":"test3","price":3,"quantity":3}]} }

    describe "#initialize" do    
        before do
            allow_any_instance_of(Store).to receive(:load_items_from_json).and_return(expected_books)
        end

        it "loads books from JSON" do
            store = Store.new
            expect(store.instance_variable_get("@books")).to eq(expected_books)
        end
    end

    it 'return quantity items' do
        store = Store.new()
        expect(store.quantity_items).to eq(13)
    end

    it 'prints display_items correctly' do
        store = Store.new
        expected_output = expected_books[:items].map.with_index(1) do |item, index|
          "#{index}. #{item[:type]} - #{item[:title]} - #{item[:price]}" 
        end.join("\n") + "\n"
        expect { store.display_items }.to output(expected_output).to_stdout
    end
end