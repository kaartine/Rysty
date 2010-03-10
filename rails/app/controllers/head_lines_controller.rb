class HeadLinesController < ApplicationController
  before_filter :find_head_line,
    :only => [:show, :edit, :destroy, :update]
      
  # GET /head_lines
  # GET /head_lines.xml
  def index
    @head_lines = Head_line.find(:all)
  end

  # GET /head_lines/1
  # GET /head_lines/1.xml
  def show
    begin
      @head_line = Head_line.find(params[:id])
    rescue 
      format_and_redirect
#      respond_to do |format|
#        format.html { redirect_to(head_line_url) }
#        format.xml  { head :ok }
#      end
    end

    if @head_line != nil
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @head_line }
      end
    end
  end

  # GET /head_lines/new
  # GET /head_lines/new.xml
  def new
    @head_line = Head_line.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @head_line }
    end
  end

  # GET /people/1/edit
  def edit
    @head_line = Head_line.find(params[:id])
  end

  # POST /people
  # POST /people.xml
  def create
    @head_line = Head_line.new(params[:head_line])

    respond_to do |format|
      if @head_line.save
        flash[:notice] = 'Head line was successfully created.'
        format.html { redirect_to(@head_line) }
        format.xml  { render :xml => @head_line, :status => :created, :location => @head_line }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @head_line.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /head_lines/1
  # PUT /head_lines/1.xml
  def update
    @head_line = Head_line.find(params[:id])

    respond_to do |format|
      if @head_line.update_attributes(params[:head_line])
        flash[:notice] = 'post was successfully updated.'
        format.html { redirect_to(@head_line) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @head_line.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /head_lines/1
  # DELETE /head_lines/1.xml
  def destroy
    @head_line = Head_line.find(params[:id])
    @head_line.destroy

    format_and_redirect
#    respond_to do |format|
#      format.html { redirect_to(head_lines_url) }
#      format.xml  { head :ok }
#    end
  end
  
private 
  def find_head_line
    @post = Head_line.find(params[:id])
  end
  
  def format_and_redirect
    respond_to do |format|
      format.html { redirect_to(head_lines_url) }
      format.xml  { head :ok }
    end
  end
end
