class Ticket < ApplicationRecord
  validates :status, inclusion: { in: %w(purchased available blocked) }
  validates :category, inclusion: { in: %w(vip regular) }
end
