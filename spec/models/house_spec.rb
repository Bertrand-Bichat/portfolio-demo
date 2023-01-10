# == Schema Information
#
# Table name: houses
#
#  id         :bigint           not null, primary key
#  address    :string
#  latitude   :float
#  longitude  :float
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_houses_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe House, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    before do
      user = create(:user, :with_customer_role)
      subject { build(:house, user: user) }
    end
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
  end
end
