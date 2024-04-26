# frozen_string_literal: true

Rails.application.routes.draw do
  mount GrapeApi => '/'
  mount GrapeSwaggerRails::Engine => '/swagger'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  get '/', to: redirect('/swagger')
end
