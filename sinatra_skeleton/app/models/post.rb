class Post < ActiveRecord::Base
  has_many :comments, :as => :commentable
  belongs_to :creator, :class_name => "User", :foreign_key => :creator_id
end
