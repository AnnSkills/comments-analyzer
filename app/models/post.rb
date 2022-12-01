class Post < ApplicationRecord
  has_many :comments
  validates :url, presence: true
  validates :name, presence: true
end
