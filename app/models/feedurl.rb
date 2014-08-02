class Feedurl < ActiveRecord::Base
  attr_accessible :feed_title, :feed_url
  has_many :feedentries, dependent: :destroy

  validates :feed_url,  presence: true
end
