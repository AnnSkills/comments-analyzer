class Post < ApplicationRecord
  has_many :comments
  validates :url, presence: true, uniqueness: true
end
