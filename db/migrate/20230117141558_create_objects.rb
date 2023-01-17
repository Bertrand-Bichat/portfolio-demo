class CreateObjects < ActiveRecord::Migration[6.1]
  def change
    create_view :objects
  end
end
