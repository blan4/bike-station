class RentsController < ApplicationController
  before_action :find_station

  def index
    @form = RentInput.new
    @rents = Rent.openned
  end

  def show
    @rent = Rent.find(params[:id])
  end

  def open
    @form = RentInput.new open_rent_params
    service = RentService.new
    push_sender = PushSenderFactory.build
    
    if @form.valid?
      rent = service.open_rent(@form, @station)
      push_sender.send_notification_to(rent.bike, {user: rent.user.attributes, rent: rent.attributes, code: 'open'})
      redirect_to station_rents_path(@station)
    else
      @rents = Rent.openned # TODO: only for rendering errros. Replase method with ajax and remove it
      render :index
    end
  end

  def close
    service = RentService.new
    push_sender = PushSenderFactory.build

    rent = service.close_rent(params[:id], @station)
    if rent.nil?
      flash[:danger] = "Can't close rent."
      redirect_to station_rents_path(@station)
    else
      push_sender.send_notification_to(rent.bike, {user: rent.user.attributes, rent: rent.attributes, code: 'close'})
      redirect_to station_rent_path(@station, rent)
    end
  end

  private
  def open_rent_params
    params.require(:rent_input)
  end

  def find_station
    @station = Station.find params[:station_id]
  end
end
