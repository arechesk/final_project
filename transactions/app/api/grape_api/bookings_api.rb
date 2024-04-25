# frozen_string_literal: true

require 'redis'
class GrapeApi
  class BookingsApi < Grape::API
    format :json
    namespace :bookings do
      desc 'Список всех бронирований'
      get do
        redis = Redis.new(url: ENV['REDIS_URL'])
        bookings = redis.keys('booking_*')
        return JSON.parse('[]') if bookings.empty?

        result_json = '['
        bookings.each do |booking|
          result_json += "{\"booking_id\":#{booking.split('_')[1]},"
          result_json += "#{redis.get(booking)[1..]},"
        end
        result_json = "#{result_json[0...-1]}]"
        present JSON.parse(result_json)
      end
      params do
        requires :type, type: String
        requires :date, type: Date
      end
      desc 'Создание новой брони'
      post do
        # TODO: изменить направление в update booking
        # TODO GET /tickets/check_availability
        uri = URI('http://tickets:3000/check_availability')
        params = { type: params[:type], date: params[:date] }
        response = Net::HTTP.get(uri, params)
        response = { result: true, ticket_id: rand(1..1000), cost: rand(1000..2000) }
        redis = Redis.new(url: ENV['REDIS_URL'])
        booking_id = redis.incr('counter')+rand(3000..4000)
        booking = { ticket_id: response[:ticket_id], price: response[:cost] }
        redis.setex("booking_#{booking_id}", 5 * 60, booking.to_json)
        present JSON.parse "{\"result\": true, \"message\":  \"successfully booked\", \"booking_id\": #{booking_id}}"
      end
      route_param :id, type: Integer do
        desc 'Удаление брони по id'
        delete do
          redis = Redis.new(url: ENV['REDIS_URL'])
          redis.del(redis.keys("#{"booking_#{params[:id]}"}*")[0])
          status 204
          present JSON.parse('{"result": true, "message":  "successfully deleted"}')
        end
      end
    end
  end
end
