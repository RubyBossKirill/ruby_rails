RSpec.describe Customer do 
    let(:expected_books) { {"items":[{"type":"film","title":"Леон","year":1994,"director":"Люк Бессон","price":990,"quantity":5},{"type":"film","title":"Дурак","year":2014,"director":"Юрий Быков","price":390,"quantity":1},{"type":"book","title":"Идиот","author":"Федор Достоевский","price":1500,"quantity":10},{"type":"film","title":"Леон","year":1994,"director":"Люк Бессон","price":990,"quantity":5},{"type":"sadasdaf","title":"Леон","year":1994,"director":"Люк Бессон","price":990,"quantity":5},{"type":"books","title":"Gun Bitch","year":1999,"director":"Kir El","price":1099,"quantity":1},{"type":"types","title":"Ivan","year":1998,"director":"El kir","price":1000,"quantity":1},{"type":"film","title":"Kirill Muchenik","year":2024,"director":"Elin Kir","price":2000,"quantity":1},{"type":"dvcxvx","title":"dsgds","year":1233,"director":"sdgdf","price":2131,"quantity":1},{"type":"ljkdgslkd","title":"dgsdfg","year":1234,"director":"agdfgsd","price":24234,"quantity":1},{"type":"test","title":"test","year":1,"director":"test","price":1,"quantity":1},{"type":"test1","title":"test1","year":1,"director":"test","price":2,"quantity":2},{"type":"test3","title":"test3","year":3,"director":"test3","price":3,"quantity":3}]} }

    it 'check initialize, store_list' do
        cust = Customer.new(expected_books)
        expect(cust.instance_variable_get("@store_list")).to eq(expected_books)
    end

    it 'check record_basket_user' do
        cust = Customer.new(expected_books)
        expect(cust.record_basket_user(expected_books)).to eq(expected_books)
    end

    # it 'check view_cart' do
    #     cust = Customer.new(expected_books)
    #     count_cust = [3, 5]
    #     p expected_books[:items]
    #     expected_cust = count_cust.map {|file_id| expected_books[:items][file_id]} 
    #     expect(cust.view_cart).to eq(expected_cust)
    # end

    # def view_cart
    #     user_basket_final = @user_basket.map { |file_id| @store_list.check_index(file_id) }
    # end
end