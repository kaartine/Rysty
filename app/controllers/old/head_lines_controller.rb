class HeadLinesController < ApplicationController
  before_filter :find_head_line, :only => [:show, :edit, :destroy, :update]   
      
  # GET /head_lines
  # GET /head_lines.xml
  def index
    @head_lines = HeadLine.find(:all)
  end

  # GET /head_lines/1
  # GET /head_lines/1.xml
  def show
    format_and_redirect

    if @head_line != nil
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @head_line }
      end
    end
  end
  
private 
  def find_head_line
    @head_line = HeadLine.find(params[:id])
  end
  
  def format_and_redirect
    respond_to do |format|
      format.html { redirect_to(head_lines_url) }
      format.xml  { head :ok }
    end
  end
end
