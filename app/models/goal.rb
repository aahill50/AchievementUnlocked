class Goal < ActiveRecord::Base
  validates :title, :user_id, presence: true

  belongs_to :user, inverse_of: :goals
end
