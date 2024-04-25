require 'net/http'
require "json"
require "open-uri"
class TicketsController < ApplicationController
  def index
    url = "http://tickets:3000/tickets"
    data = URI.open(url).read
    render json: JSON.parse(data)
    # uri = URI('http://app-tickets:8080/tickets')
    # response = Net::HTTP.get(uri)
    # render json: JSON.parse(response)
 end

 def update
    uri = URI("http://tickets:3000/tickets/#{params[:id]}")
    response = Net::HTTP.patch(uri, { status: params[:status] })
    render json: JSON.parse(response.body)
 end

 def show
    uri = URI("http://tickets:3000/tickets/#{params[:id]}")
    response = Net::HTTP.get(uri)
    render json: JSON.parse(response)
 end

 def cost
    uri = URI("http://tickets:3000/tickets/cost?date=#{params[:date]}&type=#{params[:type]}")
    response = Net::HTTP.get(uri)
    render json: JSON.parse(response)
 end
end
