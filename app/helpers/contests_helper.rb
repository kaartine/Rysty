module ContestsHelper

  def contest_contests_to_choose_from(season)
    Contest.all(:order => "name ASC", :conditions => ['season = ? ', @season]).collect {|p| 
      if !params[:contest].nil? && p.id == params[:contest][:id]
        [p.short_name, p.id, 'selected']
      else
        [p.short_name, p.id]
      end
    }
  end
    
  def contest_contests_grouped_in_years
    container = Array.new
    (APP_CONFIG['current_season']-1).downto(APP_CONFIG['first_season']).each do |i|
      Contest.all(:order => "name ASC", :conditions => ['season = ? ' + contests_except_those_that_are_followed,i]).each do |j|
        container.push( [i.to_s + ' - ' + j.short_name, j.id])
      end
    end
    container
  end
end
