# == Schema Information
#
# Table name: items
#
#  id         :bigint
#  class_type :text
#  created_at :datetime
#  updated_at :datetime
#  user_id    :bigint
#
class Item < ApplicationRecord

  # this isn't strictly necessary, but it will prevent
  # rails from calling save, which would fail anyway.
  def readonly?
    true
  end
end
