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
end
