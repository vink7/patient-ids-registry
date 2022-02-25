require 'rails_helper'

RSpec.describe Rec, type: :model do

  describe "#valid?" do
    context "when exp_date is a date in the future" do
      let(:rec) { build(:rec) }
      it 'is valid' do
        expect(rec).to be_valid
      end
    end
  end

  describe "#valid?" do
    context "when exp_date is a date in the past" do
      let(:rec) { build(:rec, :exp_date => Faker::Date.backward(200)) }
      it 'is invalid' do
        expect(rec).to_not be_valid
      end
    end
  end

end
