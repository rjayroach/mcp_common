
module McpCommon
  class LocationJob
    include SuckerPunch::Job
  
    # 
    # Update the lattitue and logitude of the model
    #
    def perform(id, action)
      ActiveRecord::Base.connection_pool.with_connection do
        f = Location.find(id)
        Rails.logger.warn { "Geolocating for location id: #{f.id}" }
        f.send(action)
        f.save(validate: false)
      end
    end

  end
end 
 

