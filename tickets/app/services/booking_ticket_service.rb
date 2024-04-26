class BookingTicketService

  def self.find_available_ticket(params)
    client = HTTPClient
    url="http://transaction:3001/bookings"
    response=JSON.parse(client.get(url).body)
    booked_tickets=[]
    response.each {|booking| booked_tickets<<booking["ticket_id"]}

    tickets=Ticket.where(date: params[:date], category: params[:category],status: "available")
    tickets=tickets.where.not(id: booked_tickets)
    tickets.find_by(date: params[:date], category: params[:category])
  end

end
