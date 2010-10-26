# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def edit_and_destroy(model, name)
    edit_command = "edit_" + name + "_path(model)"
    s = "<p>"
    s += link_to 'Edit', eval(edit_command)
    s += "<br />"
    s += link_to t(:t_destroy), model, :confirm => t(:t_are_you_sure), :method => :delete
    s += "</p>"
  end
  
  def back_link(return_path)
    link_to(t(:t_back), return_path)
  end
  
  def show_back_links(model, name, return_path)
    show_link(model, name) + " | " + back_link(return_path)
  end
  
  def edit_back_links(model, name, return_path)
    edit_link(model, name) + " | " + back_link(return_path)
  end


  def edit_link(model, name)
    edit_command = "edit_" + name + "_path(model)"
    link_to(t(:t_edit), eval(edit_command))
  end

  def show_link(model, name)
    show_command = name + "_path(model)"      
    link_to(t(:t_show), eval(show_command))
  end
  
  def destroy_link(model, name)
    destroy_command = name + "_path(model)"
    link_to(t(:t_destroy), eval(destroy_command), :confirm => t(:t_are_you_sure), :method => :delete)
  end
  
  def show_edit_and_destroy_for_table(model, name)
    s = "<td>" + show_link(model, name) + "</td>"
    s << "<td>"
    s << edit_link(model, name)
    s << "</td><td>"
    s << destroy_link(model, name)
    s << "</td>"
  end

  def create_new(name)
    if(session[:add_edit_delete] or session[:admin])
      s = ""
      add_command = "new_" + name + "_path"
      s += link_to t(:add), eval(add_command)
    else
      t :t_no_rights
    end
  end

  def list_contests
    if FollowedContest.exists?(:user_id => session[:id])
      
      contests = FollowedContest.find(:all, :conditions => ["user_id = ?", session[:id]])
        
      s = "<ul>"
      for contest in contests
        s << "<li>" 
        s << link_to( Contest.find(contest.contest_id).short_name, '/contests/' + contest.contest_id.to_s)
        s << "</li>"
      end
      s << "</ul>"
    else       
      t :t_no_contests_to_follow
    end
  end

  def is_logged_in
    !session[:id].nil?
  end
  def is_admin
    session[:admin]
  end
      
  def is_league_admin
    session[:league_admin]
  end

  def is_club_admin
    session[:club_admin]
  end

  def is_team_admin
    session[:team_admin]
  end
  
  def league_admin_menu
    if is_league_admin
      t(:t_leagues)
      link_to t(:t_leagues)
    else
      t(:t_no_leagues)
    end
  end
  
end
