# Read about factories at https://github.com/thoughtbot/factory_girl

module McpCommon
  FactoryGirl.define do
    factory :mcp_common_person, class: Person do
      first_name "MyString"
      last_name "MyString"
      #personable ""
    end
  end
end
