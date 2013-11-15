module McpCommon
  class Person < ActiveRecord::Base
    attr_accessible :first_name, :last_name, :personable
  end
end
