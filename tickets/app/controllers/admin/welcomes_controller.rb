class Admin::WelcomesController < ApplicationController
  def index
    render plain: "Welcome"
  end
end
