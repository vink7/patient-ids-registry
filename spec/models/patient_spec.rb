require 'rails_helper'

RSpec.describe Patient, type: :model do

  let(:patient) { build(:patient) }

  describe "#valid?" do
    context "given valid params" do
      let(:patient) { build(:patient) }
      it 'is valid' do
        expect(patient).to be_valid
      end
    end
  end

end
