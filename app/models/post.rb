class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  belongs_to :genre
  has_many :sentances
  has_attached_file :image
  #do_not_validate_attachment_file_type :image
  has_attached_file :image
  validates_attachment_presence :image
  validates_attachment_content_type :image, :content_type => /image/
  validates :title, :genre, presence: true

  def generate_content
    story = ""
    self.sentances.each {|sentance|
      story += " " + sentance.content.capitalize
      story += "." if story[-1] != "!" && story[-1] != "?" && story[-1] != "."
    }
    story
  end

  def turn_content_into_sentances(content)
    self.sentances.each {|sentance| sentance.destroy}
    content_array = content.split(/((?<=[a-z0-9)][.?!])|(?<=[a-z0-9][.?!]"))\s+(?="?[A-Z])/)
    content_array.each { |content|
      sentance = Sentance.new(content: content)
      sentance.user = self.user
      sentance.post = self
      sentance.save unless content == " " || content == ""
      }
  end

  def last_poster
    return nil if self.sentances.count < 1
    self.sentances.last.user.username
  end
end
