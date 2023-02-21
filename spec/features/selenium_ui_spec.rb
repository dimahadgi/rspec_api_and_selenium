RSpec.describe 'UI tests using Selenium', type: :feature do
  before(:each) do
    @driver = Selenium::WebDriver.for :chrome
  end

  after(:each) do
    @driver.quit
  end

  it "should successfully login to #{CommonTestData::TEST_URL} with correct username/password" do
    @driver.navigate.to CommonTestData::TEST_URL
    user_name_element = @driver.find_element(:id, 'user-name')
    user_name_element.send_keys CommonTestData::USERS[:valid_username]
    password_element = @driver.find_element(:id, 'password')
    password_element.send_keys CommonTestData::USERS[:valid_password]
    password_element.submit

    expect(@driver.current_url).to eq CommonTestData::EXPECTED_DATA[:expected_url]
  end

  it "should fail to login to #{CommonTestData::TEST_URL} with invalid username/password" do
    @driver.navigate.to CommonTestData::TEST_URL
    user_name_element = @driver.find_element(:id, 'user-name')
    user_name_element.send_keys CommonTestData::USERS[:invalid_username]
    password_element = @driver.find_element(:id, 'password')
    password_element.send_keys CommonTestData::USERS[:invalid_password]
    password_element.submit
    error_element = @driver.find_element(:class, 'error-message-container')

    expect(error_element.text).to eql CommonTestData::EXPECTED_DATA[:invalid_user_error_message]
  end

  it "should fail to login to #{CommonTestData::TEST_URL} with empty username/password" do
    @driver.navigate.to CommonTestData::TEST_URL
    password_element = @driver.find_element(:id, 'password')
    password_element.submit
    error_element = @driver.find_element(:class, 'error-message-container')

    expect(error_element.text).to eql CommonTestData::EXPECTED_DATA[:empty_user_error_message]
  end
end
