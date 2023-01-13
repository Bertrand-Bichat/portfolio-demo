require 'rails_helper'

RSpec.describe HousesFromUserChannel, type: :channel do
  describe 'subscription' do
    context '#with user_id' do
      it 'successfully subscribes' do
        subscribe user_id: 10
        expect(subscription).to be_confirmed
      end
    end

    context '#without user_id' do
      it 'rejects subscription' do
        subscribe user_id: nil
        expect(subscription).to be_rejected
      end
    end
  end
end
