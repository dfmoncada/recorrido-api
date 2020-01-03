class TripsController < ApplicationController
  def index
    trips = Trip.where(search_params)
                .for_date(date)
                .for_bus_params(bus_params)
                .order(start_time: :desc)
                .includes(:bus)

    render json: trips
  end

  private

    def date
      params[:date] &&
        Date.parse(params[:date])
    end

    def search_params
      params.permit(:route_id)
    end

    def bus_params
      params.permit(:plate)
    end
end
