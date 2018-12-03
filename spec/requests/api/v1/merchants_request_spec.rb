require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body)

    expect(merchants["data"].count).to eq(3)
  end

  it "can get one merchant by its id" do
   id = create(:merchant).id

   get "/api/v1/merchants/#{id}"

   merchant = JSON.parse(response.body)

   expect(response).to be_successful
   expect(merchant["data"]["id"].to_i).to eq(id)
 end
  it 'can find a merchant by id' do
    id = create(:merchant).id

    get "/api/v1/merchants/find?id=#{id}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["id"]).to eq(id)
  end

  it 'can find a merchant by name' do
    name = create(:merchant).name

    get "/api/v1/merchants/find?name=#{name}"

    merchant = JSON.parse(response.body)

    expect(response).to be_successful
    expect(merchant["data"]["attributes"]["name"]).to eq(name)
  end

  it 'can find a merchant by created_at' do
    merchant = create(:merchant, created_at: "2012-03-27 14:54:05 UTC")
    get "/api/v1/merchants/find?created_at=2012-03-27T14:54:05.000Z"

    merchant_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant_data["data"]["attributes"]["id"]).to eq(merchant.id)
  end

  it 'can find a merchant by updated_at' do
    merchant = create(:merchant, updated_at: "2012-03-27 14:54:05 UTC")
    get "/api/v1/merchants/find?updated_at=2012-03-27T14:54:05.000Z"

    merchant_data = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant_data["data"]["attributes"]["id"]).to eq(merchant.id)
  end

  it 'can find all merchants by id' do
    merchant_1, merchant_2 = create_list(:merchant, 2)

    get "/api/v1/merchants/find_all?id=#{merchant_1.id}"

    merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchants["data"].count).to eq(1)
    expect(merchants["data"][0]["attributes"]["id"]).to eq(merchant_1.id)
  end

  it 'can find all merchants by name' do
    merchant_1, merchant_2 = create_list(:merchant, 2, name: "Bob")
    merchant_3 = create(:merchant, name: "Jim")

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["attributes"]["id"]).to eq(merchant_1.id)
  end

  it 'can find all merchants by created_at' do
    merchant_1, merchant_2 = create_list(:merchant, 2, created_at: "2012-03-27 14:54:05 UTC")
    merchant_3 = create(:merchant)

    get "/api/v1/merchants/find_all?created_at=2012-03-27T14:54:05.000Z"

    merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["attributes"]["id"]).to eq(merchant_1.id)
  end

  it 'can find all merchants by updated_at' do
    merchant_1, merchant_2 = create_list(:merchant, 2, updated_at: "2012-03-27 14:54:05 UTC")
    merchant_3 = create(:merchant)

    get "/api/v1/merchants/find_all?updated_at=2012-03-27T14:54:05.000Z"

    merchants = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchants["data"].count).to eq(2)
    expect(merchants["data"][0]["attributes"]["id"]).to eq(merchant_1.id)
  end
  it 'can find a random merchant' do
    merchant_1, merchant_2, merchant_3 = create_list(:merchant, 3)

    get "/api/v1/merchants/random"

    merchant = JSON.parse(response.body)
    expect(response).to be_successful
    expect(merchant.count).to eq(1)
  end

  it 'should return customer with most successful transactions' do
    merchant = create(:merchant)

    get "/api/v1/merchants/#{merchant.id}/favorite_customer"

    expect(response).to be_successful
    customer = JSON.parse(response.body)
  end

  it 'should send top merchants by max revenue' do
    get '/api/v1/merchants/most_revenue?quantity=2'

    expect(response).to be_successful
    top_merchants = JSON.parse(response.body)
  end

  it 'should send top merchants by items sold' do
    get '/api/v1/merchants/most_items?quantity=2'

    expect(response).to be_successful
    top_merchants = JSON.parse(response.body)
  end
end
