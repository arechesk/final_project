class TicketsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:update]

  def index
    render json: { available_tickets: AvailableTicketsService.find_available_tickets }
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
      cost = TicketCostService.calculate_cost(ticket.category)
      render json: {cost: cost}, status: 200
    else
      render json: {message: "No tickets found for these parameters"}, status: 404
    end
  end

  def check_availability
    ticket = BookingTicketService.find_available_ticket(params)
    if ticket
      cost = TicketCostService.calculate_cost(ticket.category)
      render json: {result: true, ticket_id: ticket.id, cost: cost}, status: 200
    else
      render json: {result: false, message: "No tickets found for these parameters", what_the_hack: tickets}
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:status, :id)
  end
end
