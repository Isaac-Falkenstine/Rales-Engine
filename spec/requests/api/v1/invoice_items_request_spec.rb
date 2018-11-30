require 'rails_helper'

describe "Invoice items API" do
  it "sends a list of invoice_items" do
    create_list(:invoice_item, 3)

    get '/api/v1/invoice_items'

    expect(response).to be_successful

    invoice_items = JSON.parse(response.body)

    expect(invoice_items.count).to eq(3)
  end

  it "can get one invoice_item by its id" do
   id = create(:invoice_item).id

   get "/api/v1/invoice_items/#{id}"

   invoice_item = JSON.parse(response.body)

   expect(response).to be_successful
   expect(invoice_item["id"]).to eq(id)
 end
 it 'can find a invoice_item by id' do
   id = create(:invoice_item).id

   get "/api/v1/invoice_items/find?id=#{id}"

   invoice_item = JSON.parse(response.body)

   expect(response).to be_successful
   expect(invoice_item["data"]["attributes"]["id"]).to eq(id)
 end

 it 'can find a invoice_item by status' do
   status = create(:invoice_item).status

   get "/api/v1/invoice_items/find?status=#{status}"

   invoice_item = JSON.parse(response.body)

   expect(response).to be_successful
   expect(invoice_item["data"]["attributes"]["status"]).to eq(status)
 end

 it 'can find a invoice_item by created_at' do
   invoice_item = create(:invoice_item, created_at: "2012-03-27 14:54:05 UTC")
   get "/api/v1/invoice_items/find?created_at=2012-03-27T14:54:05.000Z"

   invoice_item_data = JSON.parse(response.body)
   expect(response).to be_successful
   expect(invoice_item_data["data"]["attributes"]["id"]).to eq(invoice_item.id)
 end

 it 'can find a invoice_item by updated_at' do
   invoice_item = create(:invoice_item, updated_at: "2012-03-27 14:54:05 UTC")
   get "/api/v1/invoice_items/find?updated_at=2012-03-27T14:54:05.000Z"

   invoice_item_data = JSON.parse(response.body)
   expect(response).to be_successful
   expect(invoice_item_data["data"]["attributes"]["id"]).to eq(invoice_item.id)
 end

 it 'can find all invoice_items by id' do
   invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2)

   get "/api/v1/invoice_items/find_all?id=#{invoice_item_1.id}"

   invoice_items = JSON.parse(response.body)
   expect(response).to be_successful
   expect(invoice_items["data"].count).to eq(1)
   expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
 end

 it 'can find all invoice_items by status' do
   invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2)
   invoice_item_3 = create(:invoice_item, status: "Big bim")

   get "/api/v1/invoice_items/find_all?status=#{invoice_item_1.status}"

   invoice_items = JSON.parse(response.body)
   expect(response).to be_successful
   expect(invoice_items["data"].count).to eq(2)
   expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
 end

 it 'can find all invoice_items by created_at' do
   invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, created_at: "2012-03-27 14:54:05 UTC")
   invoice_item_3 = create(:invoice_item)

   get "/api/v1/invoice_items/find_all?created_at=2012-03-27T14:54:05.000Z"

   invoice_items = JSON.parse(response.body)
   expect(response).to be_successful
   expect(invoice_items["data"].count).to eq(2)
   expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
 end

 it 'can find all invoice_items by updated_at' do
   invoice_item_1, invoice_item_2 = create_list(:invoice_item, 2, updated_at: "2012-03-27 14:54:05 UTC")
   invoice_item_3 = create(:invoice_item)

   get "/api/v1/invoice_items/find_all?updated_at=2012-03-27T14:54:05.000Z"

   invoice_items = JSON.parse(response.body)
   expect(response).to be_successful
   expect(invoice_items["data"].count).to eq(2)
   expect(invoice_items["data"][0]["attributes"]["id"]).to eq(invoice_item_1.id)
 end
 it 'can find a random invoice_item' do
   invoice_item_1, invoice_item_2, invoice_item_3 = create_list(:invoice_item, 3)

   get "/api/v1/invoice_items/random"

   invoice_item = JSON.parse(response.body)
   expect(response).to be_successful
   expect(invoice_item.count).to eq(1)
 end
end
