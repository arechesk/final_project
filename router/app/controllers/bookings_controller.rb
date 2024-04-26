require 'net/http'

class BookingsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create, :destroy]

  def create
    uri = URI('http://transaction:3001/bookings')
    params = { date: booking_params[:date], category: booking_params[:category] }
    response = Net::HTTP.post_form(uri, params)
    render json: JSON.parse(response.body)
  end

  def destroy
    uri = URI("http://transaction:3001/bookings/#{params[:id]}")
    response = Net::HTTP.delete(uri)
    render json: JSON.parse(response.body)
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :category)
  end
end
