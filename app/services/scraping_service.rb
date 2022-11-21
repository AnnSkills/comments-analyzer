class ScrapingService
  def initialize(post)
    @post = post
  end

  def scrape
    @post.name = take_document.css('title').text
    comments_list = take_document.css('#comment-list-wrapper')
    if comments_list.count > 0
      comments_list.each do |comment|
        @post.comments.text = comment.css('li > div > div.pmc-u-font-family-georgia > p').map(&:text)
        @post.comment.post_id = @post.id
        sentiment = RapidApiService.new(comment).sentiment_request
        rating = RatingService.new(sentiment['sentiment'], comment)
        @post.comments.rating = rating.rate_comment
        @post.rating = rating.rate_post
      end
    end
  end

  private

  def take_document
    config
    browser = Capybara.current_session
    driver = browser.driver.browser
    browser.visit(@post.url)
    Nokogiri::HTML(driver.page_source)
  end

  def config
    CapybaraService.new.config_capybara
  end
end
