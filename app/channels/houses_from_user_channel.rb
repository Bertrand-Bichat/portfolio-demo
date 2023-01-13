class HousesFromUserChannel < ApplicationCable::Channel
  def subscribed
    reject unless params[:user_id].present?
    stream_from "houses_from_user_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
