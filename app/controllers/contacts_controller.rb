class ContactsController < ApplicationController
  load_and_authorize_resource :hub, :through => :current_user
  load_and_authorize_resource :group, :through => :hub
  load_and_authorize_resource :contact, :through => :group
  
  # GET /users/:user_id/hubs/:hub_id/contacts
  # GET /users/:user_id/hubs/contacts.json
  def index #TODO redundant with parent#show
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb @group.name, hub_group_path(@hub, @group)
    add_breadcrumb 'Contacts', hub_group_contacts_path(@hub, @group)
    
    @contacts = @group.contacts

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contacts }
    end
  end

  # GET /users/:user_id/hubs/contacts/1
  # GET /users/:user_id/hubs/contacts/1.json
  def show
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb @group.name, hub_group_path(@hub, @group)
    add_breadcrumb @contact.name, hub_group_contact_path(@hub, @group, @contact)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contact }
    end
  end

  # GET /users/:user_id/hubs/contacts/new
  # GET /users/:user_id/hubs/contacts/new.json
  def new
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb @group.name, hub_group_path(@hub, @group)
    add_breadcrumb 'New contact', new_hub_group_contact_path(@hub, @group)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contact }
    end
  end

  # GET /users/:user_id/hubs/contacts/1/edit
  def edit
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb @group.name, hub_group_path(@hub, @group)
    add_breadcrumb @contact.name, hub_group_contact_path(@hub, @group, @contact)
    add_breadcrumb 'Edit details', edit_hub_group_contact_path(@hub, @group, @contact)
  end

  # POST /users/:user_id/hubs/contacts
  # POST /users/:user_id/hubs/contacts.json
  def create
    @contact.group = @group

    respond_to do |format|
      if @contact.save
        format.html { redirect_to [@hub, @group, @contact], :notice => 'Contact was successfully created.' }
        format.json { render :json => @contact, :status => :created, :location => @contact }
      else
        format.html { render :action => "new" }
        format.json { render :json => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/:user_id/hubs/contacts/1
  # PUT /users/:user_id/hubs/contacts/1.json
  def update

    respond_to do |format|
      if @contact.update(params[:contact])
        format.html { redirect_to [@hub, @group, @contact], :notice => 'Contact was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @contact.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:user_id/hubs/contacts/1
  # DELETE /users/:user_id/hubs/contacts/1.json
  def destroy
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to hub_group_contacts_url }
      format.json { head :no_content }
    end
  end
end
