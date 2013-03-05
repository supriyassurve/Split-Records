class TimeRecordsController < ApplicationController
  # GET /time_records
  # GET /time_records.json
  def index
    @time_records = TimeRecord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @time_records }
    end
  end

  # GET /time_records/1
  # GET /time_records/1.json
  def show
    @time_record = TimeRecord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @time_record }
    end
  end

  # GET /time_records/new
  # GET /time_records/new.json
  def new
    @time_record = TimeRecord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @time_record }
    end
  end

  # GET /time_records/1/edit
  def edit
    @time_record = TimeRecord.find(params[:id])
  end

  # POST /time_records
  # POST /time_records.json
  def create
    @time_record = TimeRecord.new(params[:time_record])

    respond_to do |format|
      if @time_record.save
        format.html { redirect_to @time_record, notice: 'Time record was successfully created.' }
        format.json { render json: @time_record, status: :created, location: @time_record }
      else
        format.html { render action: "new" }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /time_records/1
  # PUT /time_records/1.json
  def update
    @time_record = TimeRecord.find(params[:id])

    respond_to do |format|
      if @time_record.update_attributes(params[:time_record])
        format.html { redirect_to @time_record, notice: 'Time record was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @time_record.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /time_records/1
  # DELETE /time_records/1.json
  def destroy
    @time_record = TimeRecord.find(params[:id])
    @time_record.destroy

    respond_to do |format|
      format.html { redirect_to time_records_url }
      format.json { head :no_content }
    end
  end

  # display the div for split duration
  def split_entries_div
    @time_record = TimeRecord.find(params[:id])
    # render partial: "split_entry", locals: {record_id: params[:id], old_duration: time_record.duration.to_f}, layout: false
  end
    
  # split duration
  def split_entries
    # raise params.inspect
    @time_record = TimeRecord.find(params[:id])
    description = @time_record.description
    @time_record.update_attributes(description: description, duration: params[:old_duration])
    unless params[:new_duration]==0 || params[:new_duration]==""
      TimeRecord.create(description: description, duration: params[:new_duration], parent_id: @time_record.id)
    end
    redirect_to time_records_url
  end

end
