class Tournament < ActiveRecord::Base
  has_many :brackets
  has_many :teams
  has_many :rooms
  has_many :phases
  has_many :bracketings
  has_many :games
  has_many :game_assignments
  has_many :room_assignments
  has_many :players
  has_many :buzzers
  has_many :user_assignments
  has_many :users, :through => :user_assignment
  has_many :team_results
  has_many :player_results
  
  def to_csv
    csv_string = FasterCSV.generate do |csv|
      csv << ["Tournament Name","Tournament Location","Tournament Date","Team Name"]

      self.teams.each do |team|
        csv << [self.name,self.location,self.date,team.name]
      end
    end
    return csv_string
  end
end
