# frozen_string_literal: true

class UserCardsComponent < ViewComponent::Base
  def initialize(title:, users:)
    @title = title
    @users = users
  end
end
