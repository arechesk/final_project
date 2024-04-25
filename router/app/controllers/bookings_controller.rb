require 'net/http'

class BookingsController < ApplicationController
  def create
    uri = URI('http://transaction:3000/bookings')
    params = { date: params[:date], type: params[:type] }
    response = Net::HTTP.post_form(uri, params)
    render json: JSON.parse(response.body)
 end

 def destroy
    uri = URI("http://transaction:3000/bookings/#{params[:id]}")
    response = Net::HTTP.delete(uri)
    render json: JSON.parse(response.body)
 end
end
