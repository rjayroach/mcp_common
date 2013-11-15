require 'spec_helper'

module McpCommon
  describe AppConfig do

    subject { build(:mcp_common_app_config) }

    it "has a valid factory" do
      expect(build(:mcp_common_app_config)).to be_valid
    end

    describe "Validations" do
      %w().each do |attr|
        it "requires #{attr}" do
          subject.send("#{attr}=", nil)
          expect(subject).to_not be_valid
          expect(subject.errors[attr.to_sym].any?).to be_true
        end
      end
    end


    describe "Associations" do
    end

    describe "#before_destroy" do
      it "prohibits destroy of record" do
        expect(AppConfig.count).to eq(0)
        subject.save
        expect(AppConfig.count).to eq(1)
        subject.destroy
        expect(AppConfig.count).to eq(1)
        subject.delete
        expect(AppConfig.count).to eq(0)
      end
    end

  end
end
