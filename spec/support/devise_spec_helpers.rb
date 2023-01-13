# typed: false
module DeviseSpecHelpers
  include Warden::Test::Helpers

  def login(email, password)
    within("#new_user") do
      fill_in "user_email", with: email
      fill_in "user_password", with: password
    end
    click_button "Connexion"
  end

  def create_user_and_login
    user = create(:user, :with_customer_role)
    visit "/users/sign_in"
    login(user.email, user.password)
    user
  end
end
