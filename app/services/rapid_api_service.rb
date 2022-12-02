require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class RapidApiService
  URL = URI('https://text-analysis12.p.rapidapi.com/sentiment-analysis/api/v1.1')

  def initialize(comment)
    @comment = comment
  end

  def sentiment_request
    rapid_api_configuration
    request = Net::HTTP::Post.new(URL)
    request["content-type"] = 'application/json'
    request["X-RapidAPI-Key"] = 'dd4dd5d1e3msh12fe9a9c9343181p1052cejsn4d9543962314'
    request["X-RapidAPI-Host"] = 'text-analysis12.p.rapidapi.com'
    request.body = {
      language: 'english',
      text: @comment
    }.to_json
    response = @http.request(request)
    JSON.parse(response.read_body)['sentiment']
  end

  private

  def rapid_api_configuration
    @http = Net::HTTP.new(URL.host, URL.port)
    @http.use_ssl = true
    @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end
