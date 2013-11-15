
module McpCommon

  # These methods are applied to all controllers across the application
  # NOTE This doesn't do anything right now, until find a way to inject the layout into the Application Controller
  #   so this is here for now until that is fixed
  module ActionControllerExtension

    def self.included(base)
      # TODO logging when using dummy apps (at least mcp_call) cause rails s to fail: can't find class_name
      #Rails.logger.debug { "\nLoading #{self.class_name} from #{__FILE__}" }
      #Rails.logger.debug { "\nModifying #{base.class_name} from #{__FILE__}" }
      # base.send(:include, InstanceMethods) 
      # Get a deprecation warning when setting the layout on Base
      # TODO find a way to set it in ApplicationController itself
      #base.layout  "layouts/mcp_common/application"
    end


  #  module InstanceMethods
  #   #...........
  #  end
  end


end
