# frozen_string_literal: true

require 'redis'
class GrapeApi
  class PurchasesApi < Grape::API
    format :json
    namespace :purchases do
      desc 'Вывод всех покупок'
      get do
        present Purchase.all
      end
      route_param :id, type: Integer do
        get do
          purchase = Purchase.find_by_id(params[:id])
          error!({ message: 'Purchase not found' }, 404) unless purchase
          present purchase
        end
        desc "Удаление покупки по id"
        delete do
          purchase = Purchase.find_by_id(params[:id])
          error!({ message: "Покупка не найдена" }, 404) unless purchase
          purchase.destroy
          status 204
        end
      end
      desc 'Создание новой покупки'
      params do
        requires :booking_id, type: Integer
        requires :first_name, type: String
        requires :last_name, type: String
        requires :doc_type, type: String
        requires :doc_number, type: String
      end
      post do
        redis = Redis.new(url: ENV['REDIS_URL'])
        booking = redis.get("booking_#{params[:booking_id]}")
        error!({ result: false, message: 'Booking information not found' }, 422) if booking.nil?
        purchases = Purchase.all
        purchase = purchases.where(doc_type: params[:doc_type], doc_number: params[:doc_number]).first
        error!({ result: false, message: 'This user has already purchased a ticket' }, 422) if purchase
        ticket_id = JSON.parse(booking)['ticket_id'].to_i
        Purchase.create!(ticket_id:,
                         first_name: params[:first_name],
                         last_name: params[:last_name],
                         doc_type: params[:doc_type],
                         doc_number: params[:doc_number])
        # TODO: change ticket status
        redis.del("booking_#{params[:booking_id]}")
        # byebug
        present "{'result': true, 'message': 'purchase successful', 'ticket_id': #{ticket_id}"
      end
    end
  end
end
