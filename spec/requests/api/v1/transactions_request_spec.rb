require 'rails_helper'

describe "Transactions API" do
  it "sends a list of transactions" do
    create_list(:transaction, 3)

    get '/api/v1/transactions'

    expect(response).to be_successful

    transactions = JSON.parse(response.body)

    expect(transactions.count).to eq(3)
  end

  it "can get one transaction by its id" do
   id = create(:transaction).id

   get "/api/v1/transactions/#{id}"

   transaction = JSON.parse(response.body)

   expect(response).to be_successful
   expect(transaction["id"]).to eq(id)
 end
 it 'can find a transaction by id' do
   id = create(:transaction).id

   get "/api/v1/transactions/find?id=#{id}"

   transaction = JSON.parse(response.body)

   expect(response).to be_successful
   expect(transaction["data"]["attributes"]["id"]).to eq(id)
 end

 it 'can find a transaction by name' do
   name = create(:transaction).name

   get "/api/v1/transactions/find?name=#{name}"

   transaction = JSON.parse(response.body)

   expect(response).to be_successful
   expect(transaction["data"]["attributes"]["name"]).to eq(name)
 end

 it 'can find a transaction by created_at' do
   transaction = create(:transaction, created_at: "2012-03-27 14:54:05 UTC")
   get "/api/v1/transactions/find?created_at=2012-03-27T14:54:05.000Z"

   transaction_data = JSON.parse(response.body)
   expect(response).to be_successful
   expect(transaction_data["data"]["attributes"]["id"]).to eq(transaction.id)
 end

 it 'can find a transaction by updated_at' do
   transaction = create(:transaction, updated_at: "2012-03-27 14:54:05 UTC")
   get "/api/v1/transactions/find?updated_at=2012-03-27T14:54:05.000Z"

   transaction_data = JSON.parse(response.body)
   expect(response).to be_successful
   expect(transaction_data["data"]["attributes"]["id"]).to eq(transaction.id)
 end

 it 'can find all transactions by id' do
   transaction_1, transaction_2 = create_list(:transaction, 2)

   get "/api/v1/transactions/find_all?id=#{transaction_1.id}"

   transactions = JSON.parse(response.body)
   expect(response).to be_successful
   expect(transactions["data"].count).to eq(1)
   expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
 end

 it 'can find all transactions by name' do
   transaction_1, transaction_2 = create_list(:transaction, 2, name: "Bob")
   transaction_3 = create(:transaction, name: "Jim")

   get "/api/v1/transactions/find_all?name=#{transaction_1.name}"

   transactions = JSON.parse(response.body)
   expect(response).to be_successful
   expect(transactions["data"].count).to eq(2)
   expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
 end

 it 'can find all transactions by created_at' do
   transaction_1, transaction_2 = create_list(:transaction, 2, created_at: "2012-03-27 14:54:05 UTC")
   transaction_3 = create(:transaction)

   get "/api/v1/transactions/find_all?created_at=2012-03-27T14:54:05.000Z"

   transactions = JSON.parse(response.body)
   expect(response).to be_successful
   expect(transactions["data"].count).to eq(2)
   expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
 end

 it 'can find all transactions by updated_at' do
   transaction_1, transaction_2 = create_list(:transaction, 2, updated_at: "2012-03-27 14:54:05 UTC")
   transaction_3 = create(:transaction)

   get "/api/v1/transactions/find_all?updated_at=2012-03-27T14:54:05.000Z"

   transactions = JSON.parse(response.body)
   expect(response).to be_successful
   expect(transactions["data"].count).to eq(2)
   expect(transactions["data"][0]["attributes"]["id"]).to eq(transaction_1.id)
 end
 it 'can find a random transaction' do
   transaction_1, transaction_2, transaction_3 = create_list(:transaction, 3)

   get "/api/v1/transactions/random"

   transaction = JSON.parse(response.body)
   expect(response).to be_successful
   expect(transaction.count).to eq(1)
 end
end
