class FileUploadsController < ApplicationController
  load_and_authorize_resource :hub, :through => :current_user
  load_and_authorize_resource :group, :through => :hub
  load_and_authorize_resource :file_upload, :through => :group
  
  # GET /file_uploads
  # GET /file_uploads.json
  def index
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb @group.name, hub_group_path(@hub, @group)
    add_breadcrumb 'Files', hub_group_file_uploads_path(@hub, @group)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @file_uploads }
    end
  end

  # GET /file_uploads/1
  # GET /file_uploads/1.json
  def show
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb @group.name, hub_group_path(@hub, @group)
    add_breadcrumb @file_upload.name, hub_group_file_upload_path(@hub, @group, @file_upload)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @file_upload }
    end
  end

  # GET /file_uploads/new
  # GET /file_uploads/new.json
  def new
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb @group.name, hub_group_path(@hub, @group)
    add_breadcrumb 'New file', new_hub_group_file_upload_path(@hub, @group)

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @file_upload }
    end
  end

  # GET /file_uploads/1/edit
  def edit
    add_breadcrumb 'Your hubs', :hubs_path
    add_breadcrumb @hub.name, hub_path(@hub)
    add_breadcrumb @group.name, hub_group_path(@hub, @group)
    add_breadcrumb @file_upload.name, hub_group_contact_path(@hub, @group, @file_upload)
    add_breadcrumb 'Edit details', edit_hub_group_contact_path(@hub, @group, @file_upload)
  end

  # POST /file_uploads
  # POST /file_uploads.json
  def create
    @file_upload.group = @group

    respond_to do |format|
      if @file_upload.save
        format.html { redirect_to [@hub, @group], :notice => 'File upload was successfully created.' }
        format.json { render :json => @file_upload, :status => :created, :location => [@hub, @group, @file_upload] }
      else
        format.html { render :action => "new" }
        format.json { render :json => @file_upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /file_uploads/1
  # PUT /file_uploads/1.json
  def update

    respond_to do |format|
      if @file_upload.update(params[:file_upload])
        format.html { redirect_to [@hub, @group, @file_upload], :notice => 'File upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @file_upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /file_uploads/1
  # DELETE /file_uploads/1.json
  def destroy
    @file_upload.destroy

    respond_to do |format|
      format.html { redirect_to hub_group_file_uploads_url }
      format.json { head :no_content }
    end
  end
end
