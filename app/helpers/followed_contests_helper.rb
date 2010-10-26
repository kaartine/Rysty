module FollowedContestsHelper

  def contests_except_those_that_are_followed
    
    @excluded = FollowedContest.all(:conditions => ['user_id = ?', session[:id]])
    list = @excluded.collect do |exclude|
      exclude.contest_id.to_s
    end
    
    if @excluded.count > 0
      html = 'AND id <> ' + list.join(' AND id <> ')
    else
      ''
    end
  end

  def contests_to_choose_from(season)
    Contest.all(:order => "name ASC", :conditions => ['season = ? ' + contests_except_those_that_are_followed,@season]).collect {|p| [season.to_s + ' - ' + p.name, p.id]}
  end
  
  def seasons_to_choose_from
    APP_CONFIG['current_season'].downto(APP_CONFIG['first_season']).collect { |i| [ i, i] }
  end
  
  def contests_grouped_in_years
    container = Array.new
    APP_CONFIG['current_season'].downto(APP_CONFIG['first_season']).each do |i|
      Contest.all(:order => "name ASC", :conditions => ['season = ? ' + contests_except_those_that_are_followed,i]).each do |j|
        container.push( [i.to_s + ' - ' + j.name, j.id])
      end
    end
    container
  end
end
