class Entry < ActiveRecord::Base
  belongs_to :direction
  belongs_to :user

  validates :title, :body, presence: true
end
