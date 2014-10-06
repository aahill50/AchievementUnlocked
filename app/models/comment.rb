class Comment < ActiveRecord::Base
  validates :body, presence: true
  belongs_to :commentable, polymorphic: true
  belongs_to :author, class_name: "User"
end