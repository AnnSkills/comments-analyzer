require 'nokogiri'
require 'open-uri'

BLOG  = "https://neilpatel.com/blog/voip-phone-services/"

class ParsingService
  def scrap_title
    take_document.css('title').text
  end

  def scrap_comments
    Nokogiri::HTML(URI.open(BLOG)).css('#comments').css('.inner').css('.comment-list')
  end

  private

  def take_document
    Nokogiri::HTML(URI.open(BLOG))
  end

  def get_blog_path(post)
    Nokogiri::HTML(response)
  end

  def save_comments(comments, post)
    comments.each do |comment|
      post.comments.push(Comment.create(text: comment))
    end
  end
end
