class AddWelcomeEmailToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :welcome_email, :string
  end
end
