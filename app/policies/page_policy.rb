class PagePolicy < Struct.new(:user, :page)
  def user_loggedin?
    user != nil
  end

  def home?
    true
  end

  def offline?
    true
  end

  def profil?
    user_loggedin?
  end
end
