# Read about factories at https://github.com/thoughtbot/factory_girl

module McpCommon
  FactoryGirl.define do
    factory :mcp_common_app_config, class: AppConfig do
      environment "test"
      settings { { common_field: '1' } }
    end
  end
end


