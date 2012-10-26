class HubsController < ApplicationController
  skip_authorization_check :only => :mobile_private
  skip_before_filter :authenticate_user!, :only => :mobile_private
  load_and_authorize_resource :hub, :through => :current_user, :except => :mobile_private
  
  # GET /hubs
  # GET /hubs.json
  def index #TODO redundant with home
    add_breadcrumb 'Your hubs', :hubs_path
    append_title 'Hubs'

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
    append_title @hub.name
    
    @groups = @hub.groups(:parent_id => nil)
    @private_hub_link = root_url + @hub.private_link
    @mail_hub_link = "mailto:?subject=#{@hub.name}%20Hub%Private%20Link&body=Here's%20the%20link%20to%20#{@hub.name},%20only%20people%20with%20this%20link%20can%20access%20the%20hub.%20#{@private_hub_link}"
    
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
    append_title 'New hub'
    
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
    
    append_title "Edit #{@hub.name}"
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
    @groups = @hub.groups(:parent_id => nil)
    
    #TODO Add in admin role/initial superuser then do /hubs (list all)
    @app_groups = [support_group()]
    
    respond_to do |format|
      format.html do
        render :layout => false # mobile.html.erb
      end 
    end
  end
  
  # GET /m/:private_id
  def mobile_private
    @hub = Hub.first(:private_id => params[:private_id])
    @groups = @hub.groups(:parent_id => nil)
    @app_groups = [support_group()]
    
    respond_to do |format|
      format.html do
        render 'mobile', :layout => false # mobile.html.erb
      end 
    end
  end
  
  private
  
  # Helper to create the "support" group (contact info/etc.)
  def support_group
    support_group = Group.new(:name => 'iHub Support')
    support_contact = Contact.new(:name => 'Email us for more help or suggestions.', :email => 'name@example.com') #TODO put in real e-mail/etc.
    #support_contact.group = support_group
    support_group.contacts << support_contact
    support_group
  end
end
