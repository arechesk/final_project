require 'net/http'

class PurchasesController < ApplicationController
  def create
    uri = URI('http://service.com/purchases')
    params = { booking_id: params[:booking_id], doc_type: params[:doc_type] }
    response = Net::HTTP.post_form(uri, params)
    render json: JSON.parse(response.body)
 end
end
