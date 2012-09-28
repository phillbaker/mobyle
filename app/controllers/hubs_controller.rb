class HubsController < ApplicationController
  load_and_authorize_resource :hub, :through => :current_user
  
  # GET /hubs
  # GET /hubs.json
  def index #TODO redundant with home
    add_breadcrumb 'Your hubs', :hubs_path

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @hubs }
    end
  end

  # GET /hubs/1
  # GET /hubs/1.json
  def show
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    @groups = @hub.groups(:parent_id => nil)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @hub }
    end
  end

  # GET /hubs/new
  # GET /hubs/new.json
  def new
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb 'New hub', new_hub_path
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @hub }
    end
  end

  # GET /hubs/1/edit
  def edit
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb 'Edit details', edit_hub_path(@hub)
  end

  # POST /hubs
  # POST /hubs.json
  def create
    @hub.user = current_user()

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

  # PUT /hubs/1
  # PUT /hubs/1.json
  def update

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

  # DELETE /hubs/1
  # DELETE /hubs/1.json
  def destroy
    @hub.destroy

    respond_to do |format|
      format.html { redirect_to hubs_url }
      format.json { head :no_content }
    end
  end
  
  # GET /hubs/1/mobile
  def mobile
    @groups = @hub.groups
    
    respond_to do |format|
      format.html do
        render :layout => false # mobile.html.erb
      end 
    end
  end
end
