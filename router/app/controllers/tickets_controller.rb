require 'net/http'

class TicketsController < ApplicationController
  def index
    uri = URI('http://service.com/tickets')
    response = Net::HTTP.get(uri)
    render json: JSON.parse(response)
 end

 def update
    uri = URI("http://service.com/tickets/#{params[:id]}")
    response = Net::HTTP.patch(uri, { status: params[:status] })
    render json: JSON.parse(response.body)
 end

 def show
    uri = URI("http://service.com/tickets/#{params[:id]}")
    response = Net::HTTP.get(uri)
    render json: JSON.parse(response)
 end

 def cost
    uri = URI("http://service.com/tickets/cost?date=#{params[:date]}&type=#{params[:type]}")
    response = Net::HTTP.get(uri)
    render json: JSON.parse(response)
 end
end
