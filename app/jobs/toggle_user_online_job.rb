class ToggleUserOnlineJob < ApplicationJob
  queue_as :critical

  def perform(user_id, boolean)
    user = User.find(user_id)
    user.update_columns(online: boolean) if user&.online != boolean
  end
end
