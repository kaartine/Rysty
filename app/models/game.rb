class Game < ActiveRecord::Base
  validates_presence_of :contest_id
  validates_presence_of :home_team_id
  validates_presence_of :guest_team_id
  
  validate :result_of_game
  
  belongs_to :home_team, :class_name => "Team" 
  belongs_to :guest_team, :class_name => "Team"
  
  belongs_to :contest
  belongs_to :event
  
  private
  
  def result_of_game
    if @winner_id
      if @winner_id == @home_team_id
        if @home_goals < @gust_goals
          errors.add_to_base('winner has less goals than loosing team')
        end
      elsif @winner_id == @guest_team_id
        if @home_goals > @gust_goals
          errors.add_to_base('winner has less goals than loosing team')
        end
      elsif @draw
        errors.add_to_base('winner id set when game is draw.')
      end
    elsif @draw
      if @home_goals != @gust_goals
        errors.add_to_base('Teams have different amount of goals even though game is draw.')
      end
      # if draw and winner then won in overtime
    end
  end
end