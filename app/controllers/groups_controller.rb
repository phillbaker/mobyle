class GroupsController < ApplicationController
  load_and_authorize_resource :hub, :through => :current_user
  load_and_authorize_resource :group, :through => :hub
  
  # GET /hubs/:hub_id/groups
  # GET /hubs/:hub_id/groups.json
  def index
    # @groups = Group.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @groups }
    end
  end

  # GET /hubs/:hub_id/groups/1
  # GET /hubs/:hub_id/groups/1.json
  def show
    # @group = Group.get(params[:id])
    @contacts = @group.contacts

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /hubs/:hub_id/groups/new
  # GET /hubs/:hub_id/groups/new.json
  def new
    # @group = Group.new(:hub => @hub)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /hubs/:hub_id/groups/1/edit
  def edit
    # @group = @hub.groups.get(params[:id])
  end

  # POST /hubs/:hub_id/groups
  # POST /hubs/:hub_id/groups.json
  def create
    # @group = Group.new(params[:group])
    @group.hub = @hub

    respond_to do |format|
      if @group.save
        format.html { redirect_to [@hub, @group], :notice => 'Group was successfully created.' }
        format.json { render :json => @group, :status => :created, :location => @group }
      else
        format.html { render :action => "new" }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /hubs/:hub_id/groups/1
  # PUT /hubs/:hub_id/groups/1.json
  def update
    # @group = @hub.groups.get(params[:id])

    respond_to do |format|
      if @group.update(params[:group])
        format.html { redirect_to [@hub, @group], :notice => 'Group was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /hubs/:hub_id/groups/1
  # DELETE /hubs/:hub_id/groups/1.json
  def destroy
    # @group = @hub.groups.get(params[:id])
    @group.destroy

    respond_to do |format|
      format.html { redirect_to hub_groups_url }
      format.json { head :no_content }
    end
  end
end
