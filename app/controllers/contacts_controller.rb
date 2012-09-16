class ContactsController < ApplicationController
  # GET /users/:user_id/hubs/:hub_id/contacts
  # GET /users/:user_id/hubs/contacts.json
  def index
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:hub_id])
    @contacts = Contact.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @contacts }
    end
  end

  # GET /users/:user_id/hubs/contacts/1
  # GET /users/:user_id/hubs/contacts/1.json
  def show
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:hub_id])
    @contact = Contact.get(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @contact }
    end
  end

  # GET /users/:user_id/hubs/contacts/new
  # GET /users/:user_id/hubs/contacts/new.json
  def new
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:hub_id])
    @contact = Contact.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @contact }
    end
  end

  # GET /users/:user_id/hubs/contacts/1/edit
  def edit
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:hub_id])
    @contact = Contact.get(params[:id])
  end

  # POST /users/:user_id/hubs/contacts
  # POST /users/:user_id/hubs/contacts.json
  def create
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:hub_id])
    @contact = Contact.new(params[:contact])

    respond_to do |format|
      if @contact.save
        format.html { redirect_to @contact, :notice => 'Contact was successfully created.' }
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
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:hub_id])
    @contact = Contact.get(params[:id])

    respond_to do |format|
      if @contact.update(params[:contact])
        format.html { redirect_to @contact, :notice => 'Contact was successfully updated.' }
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
    @user = User.get(params[:user_id])
    @hub = Hub.get(params[:hub_id])
    @contact = Contact.get(params[:id])
    @contact.destroy

    respond_to do |format|
      format.html { redirect_to contacts_url }
      format.json { head :no_content }
    end
  end
end
