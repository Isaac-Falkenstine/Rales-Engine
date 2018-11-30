require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body)

    expect(items.count).to eq(3)
  end

  it "can get one item by its id" do
   id = create(:item).id

   get "/api/v1/items/#{id}"

   item = JSON.parse(response.body)

   expect(response).to be_successful
   expect(item["id"]).to eq(id)
 end
 it 'can find a item by id' do
   id = create(:item).id

   get "/api/v1/items/find?id=#{id}"

   item = JSON.parse(response.body)

   expect(response).to be_successful
   expect(item["data"]["attributes"]["id"]).to eq(id)
 end

 it 'can find a item by name' do
   name = create(:item).name

   get "/api/v1/items/find?name=#{name}"

   item = JSON.parse(response.body)

   expect(response).to be_successful
   expect(item["data"]["attributes"]["name"]).to eq(name)
 end

 it 'can find a item by created_at' do
   item = create(:item, created_at: "2012-03-27 14:54:05 UTC")
   get "/api/v1/items/find?created_at=2012-03-27T14:54:05.000Z"

   item_data = JSON.parse(response.body)
   expect(response).to be_successful
   expect(item_data["data"]["attributes"]["id"]).to eq(item.id)
 end

 it 'can find a item by updated_at' do
   item = create(:item, updated_at: "2012-03-27 14:54:05 UTC")
   get "/api/v1/items/find?updated_at=2012-03-27T14:54:05.000Z"

   item_data = JSON.parse(response.body)
   expect(response).to be_successful
   expect(item_data["data"]["attributes"]["id"]).to eq(item.id)
 end

 it 'can find all items by id' do
   item_1, item_2 = create_list(:item, 2)

   get "/api/v1/items/find_all?id=#{item_1.id}"

   items = JSON.parse(response.body)
   expect(response).to be_successful
   expect(items["data"].count).to eq(1)
   expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
 end

 it 'can find all items by name' do
   item_1, item_2 = create_list(:item, 2)
   item_3 = create(:item, name: "Big bim")

   get "/api/v1/items/find_all?name=#{item_1.name}"

   items = JSON.parse(response.body)
   expect(response).to be_successful
   expect(items["data"].count).to eq(2)
   expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
 end

 it 'can find all items by created_at' do
   item_1, item_2 = create_list(:item, 2, created_at: "2012-03-27 14:54:05 UTC")
   item_3 = create(:item)

   get "/api/v1/items/find_all?created_at=2012-03-27T14:54:05.000Z"

   items = JSON.parse(response.body)
   expect(response).to be_successful
   expect(items["data"].count).to eq(2)
   expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
 end

 it 'can find all items by updated_at' do
   item_1, item_2 = create_list(:item, 2, updated_at: "2012-03-27 14:54:05 UTC")
   item_3 = create(:item)

   get "/api/v1/items/find_all?updated_at=2012-03-27T14:54:05.000Z"

   items = JSON.parse(response.body)
   expect(response).to be_successful
   expect(items["data"].count).to eq(2)
   expect(items["data"][0]["attributes"]["id"]).to eq(item_1.id)
 end
 it 'can find a random item' do
   item_1, item_2, item_3 = create_list(:item, 3)

   get "/api/v1/items/random"

   item = JSON.parse(response.body)
   expect(response).to be_successful
   expect(item.count).to eq(1)
 end
end
