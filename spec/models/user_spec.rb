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
end
