class NotificationsController < ApplicationController
  def index
    render json: { notifications: Notification.all }
  end
end