class CheckingLogsController < ApplicationController
  def index
    render json: { checking_logs: CheckingLog.all }
  end
end