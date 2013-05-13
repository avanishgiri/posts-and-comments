class User < ActiveRecord::Base
  has_many :posts, :foreign_key => "creator_id"
  has_many :comments
end
