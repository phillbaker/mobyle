class HubsController < ApplicationController
  # GET /users/:user_id/hubs
  # GET /users/:user_id/hubs.json
  def index
    @user = User.get(params[:user_id]) || not_found
    @hubs = @user.hubs

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @hubs }
    end
  end

  # GET /users/:user_id/hubs/1
  # GET /users/:user_id/hubs/1.json
  def show
    @user = User.get(params[:user_id]) || not_found
    @hub = @user.hubs

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @hub }
    end
  end

  # GET /users/:user_id/hubs/new
  # GET /users/:user_id/hubs/new.json
  def new
    @user = User.get(params[:user_id]) || not_found
    @hub = Hub.new(:user => @user)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @hub }
    end
  end

  # GET /user/:user_id/hubs/1/edit
  def edit
    @user = User.get(params[:user_id]) || not_found
    @hub = Hub.get(params[:id]) || not_found
  end

  # POST /user/:user_id/hubs
  # POST /user/:user_id/hubs.json
  def create
    @user = User.get(params[:user_id]) || not_found
    @hub = Hub.new(params[:hub])
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

  # PUT /user/:user_id/hubs/1
  # PUT /user/:user_id/hubs/1.json
  def update
    @user = User.get(params[:user_id]) || not_found
    @hub = Hub.get(params[:id])

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

  # DELETE /user/:user_id/hubs/1
  # DELETE /user/:user_id/hubs/1.json
  def destroy
    @user = User.get(params[:user_id]) || not_found
    @hub = Hub.get(params[:id]) || not_found
    @hub.destroy

    respond_to do |format|
      format.html { redirect_to user_hubs_url }
      format.json { head :no_content }
    end
  end
end
