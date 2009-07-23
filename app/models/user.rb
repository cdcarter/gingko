class User < ActiveRecord::Base
  has_many :user_assignments
  
  def has_access?(object)
    if user.admin?
      return true
    end
    
    if object.is_a?(Tournament)
      object.user_assignments.any? {|x| x.user_id = self.id }
    else
      object.tournament.user_assignments.any? {|x| x.user_id = self.id }
    end
  end
end
