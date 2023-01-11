# frozen_string_literal: true

class HouseCardComponent < ViewComponent::Base
  def initialize(house:)
    @house = house
  end
end
