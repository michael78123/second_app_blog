class Group < ActiveRecord::Base
  validates :title, presence: {message: 'Can not be blank'}

  has_many :posts
end
