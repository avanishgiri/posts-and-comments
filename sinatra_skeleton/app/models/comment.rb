class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true
  has_many :comments, :as => :commentable
  belongs_to :commenter, :class_name => "User", :foreign_key => :commenter_id
end
