class HeadLinesController < ApplicationController
  before_filter :find_head_line,
    :only => [:show, :edit, :destroy, :update]
    
  layout "main"
  
  # GET /posts
  # GET /posts.xml
  def index
    @head_lines = Head_line.find(:all)
  end

  # GET /posts/1
  # GET /posts/1.xml
  def show
    begin
      @head_line = Head_line.find(params[:id])
    rescue 
      respond_to do |format|
        format.html { redirect_to(head_line_url) }
        format.xml  { head :ok }
      end
    end

    if @head_line != nil
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @head_line }
      end
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
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

  # PUT /people/1
  # PUT /people/1.xml
  def update
    @post = Head_line.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'post was successfully updated.'
        format.html { redirect_to(@post) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /people/1
  # DELETE /people/1.xml
  def destroy
    @post = post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
  
  private 
    def find_head_line
      @post = Head_line.find(params[:id])
    end 
end
