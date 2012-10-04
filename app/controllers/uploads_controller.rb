class UploadsController < ApplicationController
  load_and_authorize_resource
  
  # GET /uploads
  # GET /uploads.json
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @uploads }
    end
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @upload }
    end
  end

  # GET /uploads/new
  # GET /uploads/new.json
  def new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @upload }
    end
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    respond_to do |format|
      if @upload.save
        result = {
          "name" => @upload.upload_file_name,
          "size" => @upload.upload_file_size,
          "url" => @upload.upload.url(:original),
          "delete_url" => upload_path(@upload),
          "delete_type" => "DELETE"
        }
        
        format.html { redirect_to @upload, :notice => 'Upload was successfully created.' }
        #format.json { render :json => @upload, :status => :created, :location => @upload }
        format.json { render :json => [result].to_json, :status => :created, :location => @upload }
      else
        format.html { render :action => "new" }
        format.json { render :json => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /uploads/1
  # PUT /uploads/1.json
  def update

    respond_to do |format|
      if @upload.update(params[:upload])
        format.html { redirect_to @upload, :notice => 'Upload was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy

    respond_to do |format|
      format.html { redirect_to uploads_url }
      format.json { head :no_content }
    end
  end
end
