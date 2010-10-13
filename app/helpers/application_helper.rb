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
  
  def edit_and_destroy_for_table(model, name)
    edit_command = "edit_" + name + "_path(model)"
    show_command = name + "_path(model)"
    s = "<td>" + link_to(t(:t_show), eval(show_command)) + "</td>"
    s << "<td>"
    s << link_to(t(:t_edit), eval(edit_command))
    s << "</td><td>"
    s << link_to(t(:t_destroy), eval(show_command), :confirm => t(:t_are_you_sure), :method => :delete)
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
    begin
      contests = FollowedContest.find(session[:id])
      s = "<ul>dds"
      contests.each do |contest|
        s << "<li>" 
        s << contest
        s << "</li>"
      end
      s << "</ul>s"
    rescue Exception       
      t :t_no_teams_to_follow
    end
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
  
  def checked_hidden(element, based_on)
#    if( based_on )
#      html = "checked = " + based_on.to_s + ", disabled = " + based_on.to_s
#    else
      html = element.to_s + ", disabled = " + based_on.to_s
 #   end
  end

end
