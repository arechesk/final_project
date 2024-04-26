require 'net/http'

class PurchasesController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    uri = URI('http://transaction:3001/purchases')
    params = {
      booking_id: purchase_params[:booking_id],
      doc_type: purchase_params[:doc_type],
      first_name: purchase_params[:first_name],
      last_name: purchase_params[:last_name],
      doc_number: purchase_params[:doc_number]
    }
    response = Net::HTTP.post_form(uri, params)
    render json: JSON.parse(response.body)
  end

  private

  def purchase_params
    params.require(:purchase).permit(:booking_id, :doc_type, :first_name, :last_name, :doc_number)
  end

end
