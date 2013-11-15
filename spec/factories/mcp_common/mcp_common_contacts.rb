# Read about factories at https://github.com/thoughtbot/factory_girl

module McpCommon
 FactoryGirl.define do
   factory :mcp_common_contact, class: Contact do
     value { Faker::PhoneNumber.phone_number }

     # TODO: factories that want to create Contacts should include creating this type of record as a trait and create this in an after(:create) block
#     contactable_id 1
#     contactable_type "McpCommon::Person"
#     association :contactable

#     factory :customer_contact do
#       contactable_type "McpPos::Customer"
#     end

   end
 end
end
