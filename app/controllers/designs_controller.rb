require "urbanairship"

class DesignsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  respond_to :html, :json, :xml

  def index
    @designs = Design.all
    respond_with @Designs
  end

  def show
    @design = Design.find(params[:id])
    respond_with @design
  end

  def new
    @design = Design.new
  end

  def edit
    @design = Design.find(params[:id])
  end

  def create
    @design = Design.new(design_params)
    # designId increases sequentially, starting at 1 if there are no designs in the queue
    @design.designId = Design.all.maximum(:designId) ? Design.all.maximum(:designId)+1 : 1
    
    # design is always in Open state initially
    @design.status = :Open
    
    # generate a random metricId between 284810601 and 284810699 (excluding multiples of 10 since these don't appear to have images)
    metricIdRandom = rand 100;
    while metricIdRandom % 10 == 0 do
      metricIdRandom = rand 100;
    end
    if (metricIdRandom < 10) then 
      @design.metricId = "28481060"+metricIdRandom.to_s 
    else 
      @design.metricId = "2848106"+metricIdRandom.to_s
    end
    
    @design.timestamp = Time.now.utc
    
    #save our entry
    @design.save
    
    # send a notification through Urban Airship
#    notification = {
#      :audience => { :tags => ['Golf'] },
#      :device_types => ['ios'],
#      :notification => {:alert => "New design #{ @design.productName} for consumer #{ @design.consumerName }", :badge => 1}
#    }
    notification = {
      :tags => ['Golf'],
      :device_types => ['ios'],
      :aps => {:alert => "New design #{ @design.productName} for consumer #{ @design.consumerName }", :badge => 1}
    }
    Urbanairship.push(notification)
    
    # Web server response
    respond_with @design
  end

  def update
    @design = Design.find(params[:id])
    @design.update_attributes([params:design])
    respond_with @design
  end

  def destroy
    @design = Design.find(params[:id])
    @design.destroy
    respond_with @design
  end
  
  def todays_queue
    @designs = Design.where(created_at: Time.now.midnight..Time.now)
    respond_with @designs
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_design
      @design = Design.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def design_params
      params.require(:design).permit(:designId, :metricId, :productName, :consumerName, :timestamp, :status)
    end
end
