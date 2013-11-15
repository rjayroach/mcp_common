
module McpCommon
  class AppConfigDecorator < Draper::Decorator
    delegate_all
  
    MAIN_PARTIALS = [] 
    TABBED_PARTIALS = [] 
    STRONG_PARAMETERS = [] 

    def main_partials
      MAIN_PARTIALS
    end

    def tabbed_partials
      TABBED_PARTIALS
    end

    def strong_parameters
      STRONG_PARAMETERS
    end

  
  end
end
  
