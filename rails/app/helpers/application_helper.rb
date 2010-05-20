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
      return s
    else
      return "no rights"
    end
  end
end
