require 'capybara'
require 'capybara/poltergeist'

class ParsingService
  include Capybara::DSL
  Capybara.default_driver = :poltergeist
  Capybara.register_driver :poltergeist do |app|
    options = { js_errors: false }
    Capybara::Poltergeist::Driver.new(app, options)
  end

  def scrape
    yield page
  end

  def self.scrape(&block)
    new.scrape(&block)
  end
end
