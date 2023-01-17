class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_view :items
  end
end
