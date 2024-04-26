class AvailableTicketsService
  def self.find_available_tickets
    client = HTTPClient
    url="http://transaction:3001/bookings"
    response=JSON.parse(client.get(url).body)
    booked_tickets=[]
    response.each {|booking| booked_tickets<<booking["ticket_id"]}

    vip_cost = TicketCostService.calculate_cost("vip")
    regular_cost = TicketCostService.calculate_cost("regular")

    available_tickets = Ticket.where(status: "available")
    .where.not(id: booked_tickets)
    .map do |ticket|
      {
        id: ticket.id,
        date: ticket.date,
        category: ticket.category,
        status: ticket.status,
        cost: ticket.category == "vip" ? vip_cost : regular_cost
      }
    end

    available_tickets
  end
end
