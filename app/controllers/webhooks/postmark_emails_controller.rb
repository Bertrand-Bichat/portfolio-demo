class Webhooks::PostmarkEmailsController < Webhooks::WebhooksController
  def delivery
    # need to create a webhook in a Postmark account with this url : https://www.example.com/webhooks/postmark/delivery-email
    body = JSON.parse(request.body.read)

    puts "---"
    puts "Body : #{body}"
    puts "---"
    puts "Metadata : #{body['Metadata']}"
    puts "---"

    user_id = body['Metadata']['user-id'].to_i
    user = User.find(user_id)

    if user.present?
      user.assign_attributes(welcome_email: "delivered")
      user.save if user.valid?
    end

    render_response(200)
  end
end
