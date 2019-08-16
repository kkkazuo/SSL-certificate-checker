class TimeController < ApplicationController
  def show
    render json: { time: Time.now }
  end
end