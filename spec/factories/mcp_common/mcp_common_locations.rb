# Read about factories at https://github.com/thoughtbot/factory_girl

module McpCommon
  FactoryGirl.define do
    factory :mcp_common_location, class: Location do

      trait :west_church_street do
        address1 '16 West Church Street'
        postal_code '14450'
        locality 'Fairport'
        country 'United States'
      end

      trait :west_church_street_geo do
        latitude 43.098901
        longitude -77.44318799999999
      end


      trait :geylang_road do
        address1 '10 Lorong 27 Geylang'
        address2 '#02-01'
        postal_code '388199'
        locality 'Singapore'
        country 'Singapore'
      end

      # The above address translates to the following coordinates
      trait :geylang_road_geo do
        latitude 1.3146203
        longitude 103.8839036
      end


      trait :beach_road do
        address1 '6001 Beach Road'
        postal_code '199589'
        locality 'Singapore'
        country 'Singapore'
      end

      trait :beach_road_geo do
        latitude 1.302128
        longitude 103.864082
      end

      
      trait :ghim_moh_road do
        address1 '15 Ghim Moh Road'
        address2 '#02-31'
        postal_code '270015'
        locality 'Singapore'
        country 'Singapore'
      end
      
      trait :ghim_moh_road_geo do
        latitude 1.309118
        longitude 103.788369
      end


    end 
  end
end

