class GroupsController < ApplicationController
  load_and_authorize_resource :hub, :through => :current_user
  load_and_authorize_resource :group, :through => :hub
  
  # GET /hubs/:hub_id/groups
  # GET /hubs/:hub_id/groups.json
  def index
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb 'Groups', hub_groups_path(@hub)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @groups }
    end
  end

  # GET /hubs/:hub_id/groups/1
  # GET /hubs/:hub_id/groups/1.json
  def show
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    @group.ancestors.each do |ancestor|
      add_breadcrumb ancestor.name, hub_group_path(@hub, ancestor)
    end
    add_breadcrumb @group.name, hub_group_path(@hub, @group)
    
    @contacts = @group.contacts

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /hubs/:hub_id/groups/new
  # GET /hubs/:hub_id/groups/new.json
  # GET /hubs/:hub_id/groups/:id/new
  # GET /hubs/:hub_id/groups/:id/new.json
  def new
    @group.parent_id = params[:group_id]
    
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    unless params[:group_id]
      add_breadcrumb 'New group', new_hub_group_path(@hub)
    else
      add_breadcrumb 'New sub group', hub_group_subgroup_path(@hub, @group.parent)
    end
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @group }
    end
  end

  # GET /hubs/:hub_id/groups/1/edit
  def edit
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb @group.name, hub_group_path(@group)
    add_breadcrumb 'Edit details', edit_hub_group_path(@hub, @group)
  end

  # POST /hubs/:hub_id/groups
  # POST /hubs/:hub_id/groups.json
  def create
    # @group.parent_id = params[:parent_id] => in the form?
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
