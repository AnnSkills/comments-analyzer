require 'uri'
require 'net/http'
require 'openssl'
require 'json'

class RapidApiService
  URL = URI('https://text-analysis12.p.rapidapi.com/sentiment-analysis/api/v1.1')

  def initialize(comments)
    @comments = comments
  end

  def rapid_api_invoke
    sentiment_request
    http = Net::HTTP.new(URL.host, URL.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    response = http.request(@request)
    response_json = JSON.parse(response.body)

    unless response_json['status_code'] != :ok
      raise ApiBadResponseError(response_json['status_code'])
    end

    response_json
  end

  private

  def sentiment_request
    @request = Net::HTTP::Post.new(URL)
    @request["content-type"] = 'application/json'
    @request["X-RapidAPI-Key"] = 'dd4dd5d1e3msh12fe9a9c9343181p1052cejsn4d9543962314'
    @request["X-RapidAPI-Host"] = 'text-analysis12.p.rapidapi.com'
    @request.body = {
      data: {
        language: 'english',
        text: @comments
      }
    }.to_json
  end
end
