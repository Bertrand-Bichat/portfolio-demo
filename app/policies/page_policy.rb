class PagePolicy < Struct.new(:user, :page)
  def user_loggedin?
    user != nil
  end

  def home?
    true
  end
end
