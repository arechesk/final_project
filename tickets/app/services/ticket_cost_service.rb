class TicketCostService
  def self.calculate_cost(category)
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
end
