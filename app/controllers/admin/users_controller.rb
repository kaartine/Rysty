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
      @rights = {:admin => false, :league_admin => false}
  
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
      get_userinfo
       
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
      end

    end
  
    def update
      get_userinfo
  
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
      get_userinfo
      
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @user }
      end
      
    end
  
  private
  
  def get_userinfo
    begin
      @user = User.find(params[:id])
      @user.password = ''
        
      logger.debug Admin.to_s
      @rights = Admin.exists?("user_id = 1")
        
#      [4;35;1mAdmin Exists (0.0ms)[0m   [0mRuntimeError: ERROR C22P02  Minvalid input syntax for integer: "user_id = 1"  P57 F.\src\backend\utils\adt\numutils.c L64 Rpg_atoi: SELECT "admins".id FROM "admins" WHERE ("admins"."id" = E'user_id = 1') LIMIT 1[0m
      
      logger.debug @rights[:admin].to_s
        # :club_admin => ClubAdmin.find_user_id([params[:id]])}
    
    rescue
      if @user.nil?
        flash[:notice] = t(:t_userid) + ':' + params[:id].to_s + t(:t_was_not_found) + '.'
        redirect_to :controller => '/admin/users'
      else
        if( @rights.nil? )
          @rights = {}
            puts "asdssds"
        end
      end
    end
  end
end
