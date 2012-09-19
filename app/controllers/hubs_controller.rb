class HubsController < ApplicationController
  load_and_authorize_resource :hub, :through => :current_user
  
  # GET /hubs
  # GET /hubs.json
  def index #TODO redundant with parent#show
    #@user = User.get(params[:user_id]) || not_found
    #@hubs = @user.hubs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @hubs }
    end
  end

  # GET /hubs/1
  # GET /hubs/1.json
  def show
    # @user = User.get(params[:user_id]) || not_found
    # @hub = @user.hubs.get(params[:id]) || not_found
    @contacts = @hub.contacts
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @hub }
    end
  end

  # GET /hubs/new
  # GET /hubs/new.json
  def new
    # @user = User.get(params[:user_id]) || not_found
    # @hub = Hub.new(:user => @user)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @hub }
    end
  end

  # GET /hubs/1/edit
  def edit
    # @user = User.get(params[:user_id]) || not_found
    # @hub = @user.hubs.get(params[:id]) || not_found
  end

  # POST /hubs
  # POST /hubs.json
  def create
    # @user = User.get(params[:user_id]) || not_found
    # @hub = Hub.new(params[:hub])
    @hub.user = @user

    respond_to do |format|
      if @hub.save
        format.html { redirect_to [@user, @hub], :notice => 'Hub was successfully created.' }
        format.json { render :json => @hub, :status => :created, :location => @hub }
      else
        format.html { render :action => "new" }
        format.json { render :json => @hub.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hubs/1
  # PUT /hubs/1.json
  def update
    # @user = User.get(params[:user_id]) || not_found
    # @hub = @user.hubs.get(params[:id]) || not_found

    respond_to do |format|
      if @hub.update(params[:hub])
        format.html { redirect_to [@user, @hub], :notice => 'Hub was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @hub.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hubs/1
  # DELETE /hubs/1.json
  def destroy
    # @user = User.get(params[:user_id]) || not_found
    # @hub = @user.hubs.get(params[:id]) || not_found
    @hub.destroy

    respond_to do |format|
      format.html { redirect_to user_hubs_url }
      format.json { head :no_content }
    end
  end
end
