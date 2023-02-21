module CommonTestData
  TEST_URL = 'your_test_url'

  USERS = {
    :valid_username => 'standard_user',
    :valid_password => 'secret_sauce',
    :invalid_username => 'invalid_user',
    :invalid_password => 'invalid_pass'
  }

  EXPECTED_DATA = {
    :expected_url => 'your_test_url',
    :invalid_user_error_message => 'Epic sadface: Username and password do not match any user in this service',
    :empty_user_error_message => 'Epic sadface: Username is required'
  }
end

module ApiTestData
  # it's better to have API data as env variables
  API_KEY = 'your_api_key'
  API_URL = 'your_api_url'
  PET_BODY = {
    "id": 0,
    "category": {
      "id": 0,
      "name": "string"
    },
    "name": "doggie",
    "photoUrls": [
      "string"
    ],
    "tags": [
      {
        "id": 0,
        "name": "string"
      }
    ],
    "status": "available"
  }
  ORDER_BODY = {
    "id": 0,
    "petId": 0,
    "quantity": 0,
    "shipDate": "2023-02-21T16:04:48.233Z",
    "status": "placed",
    "complete": true
  }
  CONTENT_TYPE = 'application/json'
  TEST_PET_NAME = 'test_name'
end