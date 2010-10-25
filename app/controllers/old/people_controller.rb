class PeopleController < ApplicationController
  before_filter :find_person,
    :only => [:show, :edit, :destroy, :update]  

  # GET /people
  # GET /people.xml
  def index
    @people = Person.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @people }
    end
  end

  # GET /people/1
  # GET /people/1.xml
  def show
    if @person != nil
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @person }
      end
    end
  end
  
  private
    def find_person 
      @person = Person.find(params[:id])
    end 
end
