# frozen_string_literal: true

class GrapeApi < Grape::API
  mount PurchasesApi
  mount BookingsApi
  add_swagger_documentation
end
