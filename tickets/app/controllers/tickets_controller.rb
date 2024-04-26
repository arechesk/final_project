class TicketsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]
  def index
    @vip_cost = calculate_cost("vip")
    @regular_cost = calculate_cost("regular")

    @available_tickets = Ticket.where(status: "available").map do |ticket|
      {
        id: ticket.id,
        date: ticket.date,
        category: ticket.category,
        status: ticket.status,
        cost: ticket.category == "vip" ? @vip_cost : @regular_cost
      }
    end
    render json: { available_tickets: @available_tickets }
  end

  def show
    begin
      ticket = Ticket.find(params[:id])
      render json: { ticket: ticket }, status: :ok
    rescue ActiveRecord::RecordNotFound
      render json: { error: "Ticket not found" }
    end
  end

  def update
    ticket = Ticket.find(params[:id])
    if ticket.update(ticket_params)
      render json: { result: true, message: "Ticket successfully updated" }, status: 200
    else
      render json: { result: false, message: "Ticket not updated, errors: #{ticket.errors.full_messages}" }
    end
  end

  def cost
    ticket = Ticket.find_by(date: params[:date], category: params[:category])
    if ticket
      cost = calculate_cost(ticket.category)
      render json: {cost: cost}, status: 200
    else
      render json: {message: "No tickets found for these parameters"}, status: 404
    end
  end

  def calculate_cost(category)
    base_prices = {
      "vip" => ENV['VIP_TICKET_PRICE'].to_f,
      "regular" => ENV['REGULAR_TICKET_PRICE'].to_f
    }

    base_price = base_prices[category]

    total_tickets = Ticket.where(category: category).count
    purchased_tickets = Ticket.where(category: category, status: "purchased").count
    sold_percentage = (purchased_tickets.to_f / total_tickets) * 100

    additional_cost = 0

    if sold_percentage > 10
      additional_cost = (base_price * 0.1) * ((sold_percentage - 10) / 10)
    end

    final_cost = base_price + additional_cost

    final_cost.round
  end

  def check_availability
    client = HTTPClient
    url="http://transaction:3001/bookings"
    response=JSON.parse(client.get(url).body)
    booked=[]
    response.each {|booking| booked<<booking["ticket_id"]}
    tickets=Ticket.where(date: params[:date], category: params[:category],status: "available")
    tickets=tickets.where.not(id: booked)

    ticket = tickets.find_by(date: params[:date], category: params[:category])

    if ticket
      cost = calculate_cost(ticket.category)
      render json: {result: true, ticket_id: ticket.id, cost: cost}, status: 200
    else
      render json: {result: false, message: "No tickets found for these parameters", what_the_hack: tickets}
    end
    # {result: true, ticket_id: id cost: 1500}
    # {result: false}
  end

  private

  def ticket_params
    params.require(:ticket).permit(:status, :id)
  end

  # def cost_params
  #   params.permit(:date, :category)
  # end

  # def availability_params
  #   params.permit(:date, :category)
  # end
end
