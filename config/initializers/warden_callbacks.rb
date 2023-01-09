#when user sing_up
Warden::Manager.after_set_user do |user,auth,opts|
  ToggleUserOnlineJob.perform_later(user.id, true) # set online to true
end

# when user sign_in
Warden::Manager.after_authentication do |user,auth,opts|
  ToggleUserOnlineJob.perform_later(user.id, true) # set online to true
end

# when user disconnect
Warden::Manager.before_logout do |user,auth,opts|
  ToggleUserOnlineJob.perform_later(user.id, false) # set online to false
end
