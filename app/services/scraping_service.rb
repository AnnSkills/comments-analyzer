class ScrapingService
  def initialize(post)
    @post = post
  end

  def scrape
    comments_list = take_document.css('.comment')
    if comments_list.count > 0
      comments_list.each do |comment|
        text = comment.css('div.pmc-u-font-family-georgia > p').map(&:text)
        sentiment = RapidApiService.new(text.first).sentiment_request
        comment_rating_service = CommentRatingService.new(sentiment)
        comment_rate = comment_rating_service.rate_comment
        comment = Comment.create(text: text.first, post: @post, rate: comment_rate)
        p comment.errors.full_messages
      end
    end
    comments = Comment.where(post_id: @post.id)
    p comments
    byebug
    if comments != nil
    post_rating_service = PostRatingService.new(comments)
    post_rate = post_rating_service.rate_post
    @post.update(name: take_document.css('title').text, rating: post_rate)
    else
      @post.update(name: take_document.css('title').text, rating: 0)
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
