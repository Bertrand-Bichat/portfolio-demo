class HousesFromUserChannel < ApplicationCable::Channel
  def subscribed
    stream_from "houses_from_user_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end