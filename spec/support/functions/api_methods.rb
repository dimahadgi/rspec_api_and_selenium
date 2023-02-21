module ApiMethods
  module_function

  ##
  # Send post request
  #
  # @param body (Hash) request body to send
  # @param uri (Object) URI Object
  #
  # @return [Object] Net::HTTPResponse object
  #
  def send_post(body, uri)
    Net::HTTP.post uri, body.to_json, "Content-Type" => ApiTestData::CONTENT_TYPE
  end

  ##
  # Send get request
  #
  # @param uri (Object) URI Object
  #
  # @return [Object] Net::HTTPResponse object
  #
  def send_get(uri)
    Net::HTTP.get_response(uri)
  end

  ## Send put request
  #
  # @param body (Hash) request body to send
  # @param uri (Object) URI Object
  #
  # @return [Object] Net::HTTPResponse object
  #
  def send_put(uri, body)
    req = Net::HTTP::Put.new(uri)
    req['Content-Type'] = ApiTestData::CONTENT_TYPE
    req.body = body.to_json

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  end

  ##
  # Send delete request
  #
  # @param uri (Object) URI Object
  #
  # @return [Object] Net::HTTPResponse object
  #
  def send_delete(uri)
    req = Net::HTTP::Delete.new(uri)
    req['Content-Type'] = ApiTestData::CONTENT_TYPE
    req.add_field 'Authorization', ApiTestData::API_KEY

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  end
end