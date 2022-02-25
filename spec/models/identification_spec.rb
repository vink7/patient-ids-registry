require 'rails_helper'

RSpec.describe Identification, type: :model do

  let(:identification) { build(:identification) }

  describe "#valid?" do
    context "when exp_date is a date in the future" do
      let(:identification) { build(:identification) }
      it 'is valid' do
        expect(identification).to be_valid
      end
    end
  end

  describe "#valid?" do
    context "when exp_date is a date in the past" do
      let(:identification) { build(:identification, :exp_date => Faker::Date.backward(200)) }
      it 'is invalid' do
        expect(identification).to_not be_valid
      end
    end
  end

end
