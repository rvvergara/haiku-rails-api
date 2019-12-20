# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let (:ted) { build(:user, :patient) }
    let (:nomad) { build(:user, :invalid_user) }
    
    context 'complete sign up info' do
      it 'is valid' do
        expect(ted).to be_valid
      end
    end

    context 'no role given' do
      it 'is invalid' do
        expect(nomad).to_not be_valid
        expect(nomad.errors['role']).to include("can't be blank")
      end
    end
  end

  describe 'before create callback' do
    let(:doctor) { build(:user, :practitioner) }
    before { doctor.save }
    
    context 'user activation_token' do
      it 'is created' do
        expect(doctor.activation_token).to_not be(nil)
      end
    end

    context 'user activation_digest' do
      it 'is created' do
        expect(doctor.activation_digest).to_not be(nil)
      end
    end
  end

  describe 'send_activation email method' do
    context 'UserMailer.account_activation method' do
      subject { create(:user, :patient) }
      it 'sends an email' do
        expect { subject.send_activation_email }
          .to change { ActionMailer::Base.deliveries.count }
          .by(1)
      end
    end
  end
end
