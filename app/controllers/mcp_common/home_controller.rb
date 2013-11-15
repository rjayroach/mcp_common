require_dependency "mcp_common/application_controller"

module McpCommon
  class HomeController < ApplicationController

    skip_before_filter :authenticate_user!

    def index
      Rails.logger.debug "hello in home index"
    end

  end
end
