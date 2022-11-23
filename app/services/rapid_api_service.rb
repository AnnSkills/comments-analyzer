require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class RapidApiService
  URL = URI('https://text-analysis12.p.rapidapi.com/sentiment-analysis/api/v1.1')

  def initialize(comments)
    @comments = comments
  end

  def sentiment_request
    rapid_api_configuration
    request = Net::HTTP::Post.new(URL)
    request["content-type"] = 'application/json'
    request["X-RapidAPI-Key"] = $rapid_api_key
    request["X-RapidAPI-Host"] = $rapid_api_host
    request.body = {
      data: {
        language: 'english',
        text: @comments
      }
    }.to_json
    response = http.request(request)
    response
  end

  private

  def rapid_api_configuration
    http = Net::HTTP.new(URL.host, URL.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  end
end
