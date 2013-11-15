require 'spec_helper'

module McpCommon
  describe Location do

    subject { build :mcp_common_location, :ghim_moh_road }
  
    context "Validations" do
      %w(address1 postal_code country).each do |attr|
        it "requires #{attr}" do
          subject.send("#{attr}=", nil)
          should_not be_valid
          subject.errors.has_key?(attr.to_sym).should_not be_nil
        end
      end
    end


    #
    # Addresses resolve to the proper geocoordiates
    #
    context "Geocode by physical address" do
      [:west_church_street, :geylang_road, :beach_road, :ghim_moh_road].each do |trait|
        it "#{trait}", job: true do
          loc = create(:mcp_common_location, trait)
          VCR.use_cassette(trait.to_s) do
            expect(loc.latitude).to be_nil
            loc.run_callbacks(:commit)
            geo_loc = build(:mcp_common_location, (trait.to_s + '_geo').to_sym)
            expect(loc.reload.latitude).to eq(geo_loc.latitude)
            expect(loc.reload.longitude).to eq(geo_loc.longitude)
          end
        end # it
      end # Array
    end # #perform


    #
    # Geo-coordinates resolve to proper Addresses
    #
    context "Reverse geocode by geo-coordinates" do
      [:west_church_street, :geylang_road, :beach_road, :ghim_moh_road].each do |trait|
        it "#{trait}", job: true do
          geo_trait = "#{trait.to_s}_geo"
          geo_loc = create(:mcp_common_location, geo_trait.to_sym)
          VCR.use_cassette(geo_trait) do
            expect(geo_loc.address1).to be_nil
            geo_loc.run_callbacks(:commit)
            loc = build(:mcp_common_location, trait)
            expect(geo_loc.reload.address1).to eq(loc.address1)
            expect(geo_loc.reload.postal_code).to eq(loc.postal_code)
            expect(geo_loc.reload.locality).to eq(loc.locality)
            expect(geo_loc.reload.country).to eq(loc.country)
          end
        end # it
      end # Array
    end # #perform


    # todo What if the geocoding fails and the object is nil?
    describe "Calculating distances" do
      before(:each) do
        @loc_from = create(:mcp_common_location, :geylang_road_geo)
        @loc_to = create(:mcp_common_location, :beach_road_geo)
        @loc_to_far = create(:mcp_common_location, :ghim_moh_road_geo)
      end
  
      it "reports correct distance between itself and another location" do
        expect(Location.distance_from(@loc_from, @loc_to)).to eq(2.6)
        expect(Location.distance_from(@loc_from, @loc_to_far)).to eq(10.64)
      end

      describe "Calculate nearest" do
        it "takes a location and array of locations and returns nearest" do
          expect(Location.nearest(@loc_from, Location)).to eq(@loc_from)
        end
        it "takes a location and array of locations and returns farthest" do
          expect(Location.farthest(@loc_from, Location, 15)).to eq(@loc_to_far)
        end
        it "takes a location and an object with an array of locations and returns nearest" do
          LocProxy = Struct.new(:locations)
          proxy = LocProxy.new(Location)
          expect(Location.nearest(@loc_from, proxy)).to eq(@loc_from)
        end
        it "takes an object responding to location and array of locations and returns nearest" do
          Proxy = Struct.new(:location)
          proxy = Proxy.new(@loc_from)
          expect(Location.nearest(proxy, Location)).to eq(@loc_from)
        end
      end
    end

  
  end
end 

