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

  # display the div for split duration
  def split_entries_div
    id = params[:record_id].to_i
    time_record = TimeRecord.find(id)
    render partial: "split_entries", locals: {record_id: id, old_duration: time_record.duration.to_f}, layout: false
  end
    
    # update_split_duration removed : ShripadJ
    
  # split duration
  def split_entries
    @time_record = TimeRecord.find(params[:old_id].to_i)
    description = @time_record.description
    @time_record.update_attributes(description: description, duration: params[:old_duration])
    if params[:newrecrd]=='true'
      TimeRecord.create(description: description, duration: params[:new_record_val], parent_id: @time_record.id)
    end
    redirect_to :back
  end

end
