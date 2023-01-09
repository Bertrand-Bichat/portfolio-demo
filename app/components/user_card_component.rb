# frozen_string_literal: true

class UserCardComponent < ViewComponent::Base
  def initialize(title:, users:)
    @title = title
    @users = users
  end
end
