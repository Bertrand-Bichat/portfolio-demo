require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "#notification_welcome" do
    user = build(:user, :with_customer_role, email: 'robert@gmail.com')
    let(:mail) { UserMailer.with(user: user).notification_welcome }

    it "should have the default 'from'" do
      expect(mail.from).to eq(["contact@example.com"])
    end
    it "should have the user's email in 'to'" do
      expect(mail.to).to eq(["robert@gmail.com"])
    end
    it "should have the default 'subject'" do
      expect(mail.subject).to eq("Bienvenue sur notre site !")
    end
  end
end
