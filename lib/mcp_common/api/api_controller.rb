

module McpCommon
  module Api
    #class ApiController < ::ApplicationController
    class ApiController < ActionController::Base
      protect_from_forgery

      # Only respond to JSON requests
      respond_to :json
  
      # Uncomment for detailed request/response loggin
      #around_filter :global_request_logging

      # Parse the HTTP header for X-API-KEY to authenticate the client
      # The API KEY is a Devise token so there is a separate key for each instance of the application
      #prepend_before_filter :get_api_key
  
      #before_filter :authenticate_user!

      before_filter :set_includes

  
      private

      # 
      # See: http://stackoverflow.com/questions/2667634/include-params-request-information-in-rails-logger
      #
      def global_request_logging 
        http_request_header_keys = request.headers.keys.select{|header_name| header_name.match("^HTTP.*")}
        http_request_headers = request.headers.select{|header_name, header_value| http_request_header_keys.index(header_name)}
        Rails.logger.info "Received #{request.method.inspect} to #{request.url.inspect} from #{request.remote_ip.inspect}.  Processing with headers #{http_request_headers.inspect} and params #{params.inspect}"
        Rails.logger.debug params.to_yaml
        begin 
          yield 
        ensure 
          Rails.logger.info "Responding with #{response.status.inspect} => #{response.body.inspect}"
        end 
      end 
  
      # parses parameters for 'i' value which indicates associations to include in the rendering of JSON data
      # these variables are used by RABL to in/exclude the association data
      def set_includes
        @includes = params[:i].nil? ? [] : eval(params[:i])
        @includes_list = @includes.map{|b| b.is_a?(Hash) ? b.to_a.flatten : b}.flatten || []
        #Rails.logger.debug @includes
        #Rails.logger.debug @includes_list
      end
  
      # 
      # Deprecated: See fucntionality in McpAuth initializer for devise token authentication
      #
      def get_api_key
        if api_key = params[:auth_token].blank? && request.headers["X-API-KEY"]
          params[:auth_token] = api_key
        end
        #Rails.logger.debug params #.to_yaml
        #Rails.logger.debug "API KEY passed is #{request.headers['X-API-KEY']}"
      end
  
    end
  end
end

