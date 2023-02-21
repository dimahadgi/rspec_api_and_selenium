RSpec.describe 'API spec' do
  before :all do
    # prepare test data on the server so each test case can be independent
    test_pet_res = ApiMethods.send_post(ApiTestData::PET_BODY, URI(ApiTestData::API_URL + '/pet'))
    @test_pet_id = JSON.parse(test_pet_res.body)["id"]
    order_body = ApiTestData::ORDER_BODY.dup
    order_body[:petId] = @test_pet_id
    test_order_res = ApiMethods.send_post(order_body, URI(ApiTestData::API_URL + '/store/order'))
    @test_order_id = JSON.parse(test_order_res.body)["id"]

    skip 'Failed to create new test pet' unless test_pet_res.is_a?(Net::HTTPSuccess)
  end

  it 'gets info for existing pet using GET method' do
    res = ApiMethods.send_get(URI(ApiTestData::API_URL + '/pet' + "/#{@test_pet_id}"))

    expect(JSON.parse(res.body)["id"]).to eq @test_pet_id
    expect(res.is_a?(Net::HTTPSuccess)).to eq true
    expect(res.code).to eq '200'
  end

  it 'gets info for existing order using GET method' do
    res = ApiMethods.send_get(URI(ApiTestData::API_URL + '/store/order' + "/#{@test_order_id}"))

    res_body = JSON.parse(res.body)
    expect(res_body["id"]).to eq @test_order_id
    expect(res_body["petId"]).to eq @test_pet_id
    expect(res_body["complete"]).to eq true
    expect(res.is_a?(Net::HTTPSuccess)).to eq true
    expect(res.code).to eq '200'
  end

  it 'adds new pet using POST method' do
    res = ApiMethods.send_post(ApiTestData::PET_BODY, URI(ApiTestData::API_URL + '/pet'))

    expect(JSON.parse(res.body)["id"] > 0).to eq true
    expect(res.is_a?(Net::HTTPSuccess)).to eq true
    expect(res.code).to eq '200'
  end

  it 'updates pet using PUT method' do
    put_body = ApiTestData::PET_BODY.dup
    put_body[:id] = @test_pet_id
    put_body[:name] = ApiTestData::TEST_PET_NAME

    res = ApiMethods.send_put(URI(ApiTestData::API_URL + '/pet'), put_body)

    res_body = JSON.parse(res.body)
    expect(res_body["id"]).to eq @test_pet_id
    expect(res_body["name"]).to eq ApiTestData::TEST_PET_NAME
    expect(res.is_a?(Net::HTTPSuccess)).to eq true
    expect(res.code).to eq '200'
  end

  it 'place an order for a pet using POST method' do
    ship_date = (DateTime.now + 10).strftime("%Y-%m-%dT%H:%M:%S.%L")
    order_body = ApiTestData::ORDER_BODY.dup
    order_body[:petId] = @test_pet_id
    order_body[:shipDate] = ship_date

    res = ApiMethods.send_post(order_body, URI(ApiTestData::API_URL + '/store/order'))

    res_body = JSON.parse(res.body)
    expect(res_body["petId"]).to eq @test_pet_id
    expect(res_body["complete"]).to eq true
    expect(res_body["shipDate"]).to match /#{ship_date}/
    expect(res.is_a?(Net::HTTPSuccess)).to eq true
    expect(res.code).to eq '200'
  end

  it 'deletes order from test pet using DELETE method' do
    res = ApiMethods.send_delete(URI(ApiTestData::API_URL + '/pet' + "/#{@test_pet_id}"))

    expect(JSON.parse(res.body)["message"].to_i).to eq @test_pet_id
    expect(res.is_a?(Net::HTTPSuccess)).to eq true
    expect(res.code).to eq '200'
  end

  it 'deletes pet using DELETE method' do
    res = ApiMethods.send_delete(URI(ApiTestData::API_URL + '/store/order' + "/#{@test_order_id}"))

    expect(JSON.parse(res.body)["message"].to_i).to eq @test_order_id
    expect(res.is_a?(Net::HTTPSuccess)).to eq true
    expect(res.code).to eq '200'
  end
end
