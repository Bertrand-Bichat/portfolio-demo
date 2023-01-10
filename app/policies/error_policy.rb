class ErrorPolicy < Struct.new(:user, :error)
  def not_found?
    true
  end
  alias unacceptable? not_found?
  alias internal_server_error? not_found?
end
