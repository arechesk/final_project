require 'net/http'
require "json"
require "open-uri"
class TicketsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

  def index
    url = "http://app-tickets:8080/tickets"
    data = URI.open(url).read
    render json: JSON.parse(data)
  end

  def update
    uri = URI("http://app-tickets:8080/tickets/#{ticket_params[:id]}")
    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Patch.new(uri.request_uri)
    body = {
      "id" => 1,
      "ticket" => {
        "id" => ticket_params[:id],
        "status" => ticket_params[:status]
      }
    }
    request.content_type = "application/json"
    request.body = body.to_json
    response = http.request(request)
    render json: JSON.parse(response.body)
  end

  def show
    url = "http://app-tickets:8080/tickets/#{params[:id]}"
    data = URI.open(url).read
    render json: JSON.parse(data)
  end

  def cost
    url = "http://app-tickets:8080/tickets/cost?date=#{params[:date]}&category=#{params[:category]}"
    data = URI.open(url).read
    render json: JSON.parse(data)
  end

  def check_availability
    url = "http://app-tickets:8080/tickets/check_availability?date=#{params[:date]}&category=#{params[:category]}"
    data = URI.open(url).read
    render json: JSON.parse(data)
  end

  private

  def ticket_params
    params.require(:ticket).permit(:status, :id)
  end
end
