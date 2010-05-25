# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def edit_and_destroy(model, name)
    if(session[:add_edit_delete] or session[:admin])
      edit_command = "edit_" + name + "_path(model)"
      s = "<p>"
      s += link_to 'Edit', eval(edit_command)
      s += "<br />"
      s += link_to 'Destroy', model, :confirm => 'Are you sure?', :method => :delete
      s += "</p>"
    else
      'no rights'
    end
  end

  def create_new(name)
    if(session[:add_edit_delete] or session[:admin])
      s = ""
      add_command = "new_" + name + "_path"
      s += link_to t(:add), eval(add_command)
    else
      t :no_rights
    end
  end

end
