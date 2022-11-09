require 'nokogiri'
require 'net/http'
class ParsingService
  uri  = URI("https://problogger.com/the-ultimate-guide-to-leaving-comments-on-blogs/")
  body = Net::HTTP.get(uri)
  document = Nokogiri::HTML(body)
end
