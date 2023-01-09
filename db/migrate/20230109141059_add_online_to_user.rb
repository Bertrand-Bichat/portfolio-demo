class AddOnlineToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :online, :boolean
  end
end
