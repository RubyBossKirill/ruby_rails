RSpec.describe Store do
    describe "#initialize" do
    let(:expected_books) { {"items":[{"type":"film","title":"Леон","year":1994,"director":"Люк Бессон","price":990,"quantity":5},{"type":"film","title":"Дурак","year":2014,"director":"Юрий Быков","price":390,"quantity":1},{"type":"book","title":"Идиот","author":"Федор Достоевский","price":1500,"quantity":10},{"type":"film","title":"Леон","year":1994,"director":"Люк Бессон","price":990,"quantity":5},{"type":"sadasdaf","title":"Леон","year":1994,"director":"Люк Бессон","price":990,"quantity":5},{"type":"books","title":"Gun Bitch","year":1999,"director":"Kir El","price":1099,"quantity":1},{"type":"types","title":"Ivan","year":1998,"director":"El kir","price":1000,"quantity":1}]} }
    
    before do
      allow_any_instance_of(Store).to receive(:load_items_from_json).and_return(expected_books)
    end

    it "loads books from JSON" do
      store = Store.new
      expect(store.instance_variable_get("@books")).to eq(expected_books) # Теперь ожидаемые данные имеют строковые ключи
    end
  end

    it 'return quantity items' do
        store = Store.new()
        expect(store.quantity_items).to eq(7)
    end
end