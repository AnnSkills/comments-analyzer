require 'selenium-webdriver'
require 'nokogiri'
require 'capybara'

BLOG  = "https://deadline.com/2022/11/netflix-sports-plans-rights-bidding-1235166831/"

class ParsingService
  def scrap_title
    take_document.css('title').text
  end

  def scrap_comments
    comments_table = []
    config_capybara
    comments_list = take_document.css('#comment-list-wrapper')
    if comments_list.count > 0
      comments_list.each do |comment|
        comments_table << comment.css('li > div > div.pmc-u-font-family-georgia > p').map(&:text)
      end
    end

  end

  private

  def config_capybara
    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, browser: :chrome)
    end
    Capybara.javascript_driver = :chrome
    Capybara.configure do |config|
      config.default_max_wait_time = 30
      config.default_driver = :selenium
    end
  end

  def take_document
    browser = Capybara.current_session
    driver = browser.driver.browser
    browser.visit(BLOG)
    Nokogiri::HTML(driver.page_source)
  end
end
