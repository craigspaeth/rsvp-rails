class RsvpsController < ApplicationController
  before_action :set_event, only: [:new, :create, :thank_you]

  # GET /rsvps/new
  def new
    @rsvp = Rsvp.new name: params[:name], email: params[:email]
  end

  # POST /rsvps
  # POST /rsvps.json
  def create
    @rsvp = Rsvp.new(rsvp_params.merge event: @event)

    respond_to do |format|
      if @rsvp.save
        format.html { redirect_to thank_rsvp_url(@event) }
        format.json { render :show, status: :created, location: @rsvp }
      else
        format.html { render :new }
        format.json { render json: @rsvp.errors, status: :unprocessable_entity }
      end
    end
  end

  def thank_you
  end

  private
    def set_event
      @event = Event.friendly.find(params[:event_id])
    end

    def rsvp_params
      params[:rsvp][:guests] = params[:guests]
      params.require(:rsvp).permit(:name, :email, guests: [])
    end
end
