class Sentance < ApplicationRecord
  belongs_to :post
  belongs_to :user
  validates :content, presence: true
  validates :content, length: {maximum: 250}
end
