class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => :invite_by_newsletter
  skip_authorization_check :only => :invite_by_newsletter
  
  load_and_authorize_resource
  
  # GET /users
  # GET /users.json
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # not_found unless @user
    # @user = User.get(params[:id]) || not_found
    # authorize! :show, @user
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    # not_found unless @user
    # @user = User.get(params[:id]) || not_found
  end

  # POST /users
  # POST /users.json
  def create
    # @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    # not_found unless @user
    # @user = User.get(params[:id]) || not_found

    respond_to do |format|
      if @user.update(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    # not_found unless @user
    # @user = User.get(params[:id]) || not_found
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
  
  # POST /users/invite
  # POST /users/invite.json
  def invite_by_newsletter
    attributes = params[:user] #TODO sanitize the input here
    attributes[:invited_by_type] = 'newsletter'
    @user = User.invite!(attributes) 
    
    respond_to do |format|
      # TODO this assumes always coming from 
      if @user.errors.blank?
        #TODO do a thankyou? 
        format.html { redirect_to root_path, :notice => 'E-mail submission successful. Thanks!' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        #TODO do an error page? how do we return them to their originating page?
        format.html { render 'home/index' }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end
end
