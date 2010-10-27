class Game < ActiveRecord::Base
  validates_presence_of :contest_id
  validates_presence_of :home_team_id
  validates_presence_of :guest_team_id
  
  validate :result_of_game
  
  has_one :home_team, :class_name => "Team" 
  has_one :guest_team, :class_name => "Team"
  
  belongs_to :contest
  belongs_to :event
  
  attr_accessor :home_team_id, :guest_team_id, :contest_id, :event_id
  
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
    elsif @draw && @winner_id
      errors.add_to_base('There cannot be winner and draw flag set at the same time.')
    end
  end
end