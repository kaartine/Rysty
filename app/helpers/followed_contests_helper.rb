module FollowedContestsHelper

  def contests_except_those_that_are_followed
    
    @excluded = FollowedContest.all(:conditions => ['user_id = ?', session[:id]])
    list = @excluded.collect do |exclude|
      exclude.contest_id.to_s
    end
    
    if @excluded.count > 0
      html = 'id <> ' + list.join(' AND id <> ')
    else
      ''
    end
  end

  def contests_to_choose_from
    Contest.all(:order => "name ASC", :conditions => [contests_except_those_that_are_followed]).collect {|p| [p.name, p.id]}
  end
end
