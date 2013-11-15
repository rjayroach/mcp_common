require 'spec_helper'

module McpCommon
  describe Contact do

    context "Validations" do

      it "has a valid factory" do
        expect(create(:contact)).to be_valid
      end

      subject { build :contact }

      %w(value contactable_type contactable_id).each do |attr|
        it "requires #{attr}" do
          subject.send("#{attr}=", nil)
          should_not be_valid
          subject.errors.has_key?(attr.to_sym).should_not be_nil
        end
      end
    end
    
    describe "Associations" do
      it "belongs_to contactable" do
        expect(subject).to belong_to(:contactable)
      end
    end

    describe "Scopes" do

      # create non-trvial dataset
      before (:each) do
        @customers = 3.times.inject([]) { |res,i| res << create(:customer) }
        @customer_contacts = 5.times.inject([]) { |res,i| res << create(:contact, :contactable => @customers[1]) }
      end


      it "has the correct number of items created" do
        expect(Customer.count).to eq(3)
        expect(Contact.count).to eq(5)
      end

      it "should return a list of customers" do
        expect(Contact.customers.count).to eq(5)
      end
    end

  end
end
