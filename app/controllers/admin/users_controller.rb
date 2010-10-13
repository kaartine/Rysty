class Admin::UsersController < Admin::AdminController

#  ssl_required :create, :new, :edit, :update
#  ssl_allowed :index

  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  def new
    @user = User.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def create
    @user = User.new(params[:user])
    
    @rights = params[:rights]
#    @admin = params[:admin]

    respond_to do |format|
      if @user.valid?

        User.transaction do
          @user.save!
          
          admins.each do |ad|            
            if params[:admin]
              @new_admin = ad
              @new_admin.user_id = @user.id
              @new_admin.save!
            end
          end
          
          flash[:notice] = t(:t_user) + " " + t(:t_was_successfully_created)
          format.html { redirect_to(session[:return_to] || '/') }
          format.xml  { render :xml => @user, :status => :created, :location => @user }
        end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(admin_users_url) }
      format.xml  { head :ok }
    end
  end

  def edit
    @user = User.find(params[:id])

    @user.password = ''
  end

  def update
    @user = User.find(params[:id])

    if params[:user][:password].blank?
      params[:user].delete("password")
    end

    respond_to do |format|
      if @person.update_attributes(params[:person]) & @user.update_attributes(params[:user])
        flash[:notice] = 'User was successfully updated.' + params[:user].to_s + ' ' + @user.password
        format.html { redirect_to(@user) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    begin
      @user = User.find(params[:id])

      @user.password = ''

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
      end

    rescue
      flash[:notice] = 'User ID ' + params[:id].to_s + ' was not found.'
      redirect_to :controller => '/admin/users'
    end

  end
end
