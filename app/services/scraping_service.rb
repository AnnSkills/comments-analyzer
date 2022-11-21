class ScrapingService
  def initialize(post)
    @post = post
  end

  def scrape
    comments_list = take_document.css('#comment-list-wrapper')
    if comments_list.count > 0
      comments_list.each do |comment|
        text = comment.css('li > div > div.pmc-u-font-family-georgia > p').map(&:text)
        sentiment = RapidApiService.new(comment).sentiment_request
        rating_service = RatingService.new(sentiment['sentiment'], comment)
        comment_rate = rating_service.rate_comment
        post_rate = rating_service.rate_post
        Comment.create(text: text, post_id: @post.id, rate: comment_rate)
        @post.update(name: take_document.css('title').text, rating: post_rate)
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
