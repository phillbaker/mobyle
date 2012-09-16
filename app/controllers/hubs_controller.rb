class HubsController < ApplicationController
  # GET /users/:user_id/hubs
  # GET /users/:id/hubs.json
  def index
    @user = User.get(params[:user_id])
    @hubs = Hub.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @hubs }
    end
  end

  # GET /users/:id/hubs/1
  # GET /users/:id/hubs/1.json
  def show
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @hub }
    end
  end

  # GET /users/:id/hubs/new
  # GET /users/:id/hubs/new.json
  def new
    @user = User.get(params[:user_id])
    @hub = Hub.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @hub }
    end
  end

  # GET /user/:id/hubs/1/edit
  def edit
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:id])
  end

  # POST /user/:id/hubs
  # POST /user/:id/hubs.json
  def create
    @user = User.get(params[:user_id])
    @hub = Hub.new(params[:hub])

    respond_to do |format|
      if @hub.save
        format.html { redirect_to @hub, :notice => 'Hub was successfully created.' }
        format.json { render :json => @hub, :status => :created, :location => @hub }
      else
        format.html { render :action => "new" }
        format.json { render :json => @hub.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /user/:id/hubs/1
  # PUT /user/:id/hubs/1.json
  def update
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:id])

    respond_to do |format|
      if @hub.update(params[:hub])
        format.html { redirect_to @hub, :notice => 'Hub was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @hub.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /user/:id/hubs/1
  # DELETE /user/:id/hubs/1.json
  def destroy
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:id])
    @hub.destroy

    respond_to do |format|
      format.html { redirect_to hubs_url }
      format.json { head :no_content }
    end
  end
end
