# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  online                 :boolean
#  pseudo                 :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  slug                   :string
#  welcome_email          :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_slug                  (slug) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'enum' do
    it { is_expected.to enumerize(:role).in(:customer, :admin).with_default(:customer).with_scope(true) }
    it { is_expected.to enumerize(:welcome_email).in(:not_sent, :processed, :delivered, :opened, :clicked, :bounced).with_default(:not_sent).with_scope(true) }
  end

  describe 'validations' do
    before do
      subject { build(:user, :with_customer_role) }
    end
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it { is_expected.to validate_presence_of(:pseudo) }
    it { is_expected.to validate_uniqueness_of(:pseudo) }
  end

  describe 'test enum role' do
    context '#customer' do
      it 'should have customer role' do
        create(:user, :with_customer_role)
        expect(User.last.role).to eq('customer')
      end
    end
    context '#admin' do
      it 'should have admin role' do
        create(:user, :with_admin_role)
        expect(User.last.role).to eq('admin')
      end
    end
  end

  describe 'test enum welcome_email' do
    it 'should have welcome_email not sent' do
      create(:user, :with_customer_role)
      expect(User.last.welcome_email).to eq('not_sent')
    end
  end

  describe 'callbacks' do
    before do
      create(:user, :with_customer_role, first_name: ' jean ', last_name: ' dupond ')
    end
    context '#shape_data' do
      it 'should strip and capitalize the first_name' do
        expect(User.last.first_name).to eq('Jean')
      end
      it 'should strip and capitalize the last_name' do
        expect(User.last.last_name).to eq('Dupond')
      end
    end
  end

  describe 'scopes' do
    before do
      create(:user, :with_customer_role, online: true)
      create_list(:user, 10, :with_customer_role)
    end
    context '#with_online_true' do
      it 'should filter users with online true' do
        expect(User.with_online_true.count).to eq(1)
      end
    end
  end

  describe 'Instance methods' do
    before do
      create(:user, :with_customer_role, first_name: 'James', last_name: 'Smith')
    end
    context '#full_name' do
      it 'should display full_name' do
        expect(User.last.full_name).to eq('James Smith')
      end
    end
  end
end
