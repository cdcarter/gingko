class UserAssignment < ActiveRecord::Base
  belongs_to :user
  belongs_to :user_assignment
end
