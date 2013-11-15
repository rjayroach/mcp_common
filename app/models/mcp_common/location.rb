
module McpCommon

  # 
  # Store and geolcate addresses
  # See: https://github.com/alexreisner/geocoder
  # See: http://railscasts.com/episodes/273-geocoder?view=asciicast
  # See: http://stackoverflow.com/questions/929684/is-there-common-street-addresses-database-design-for-all-addresses-of-the-world/
  #
  class Location < ActiveRecord::Base
    attr_accessor :geolocate_method
    #attr_accessible :address1, :address2, :address3, :address4, :locality, :region, :postal_code, :country
    #attr_accessible :latitude, :longitude, :location_type

    belongs_to :locatable, polymorphic: true

    #validates :address1, :postal_code, :country, presence: true, unless: :geolocation_present?
    validates :address1, :postal_code, :country, presence: true, if: :geocoded_address_changed?

    after_validation :set_geolocate_method

    after_commit :do_geolocate, if: :persisted?

    geocoded_by :geocoded_address

    reverse_geocoded_by :latitude, :longitude do |obj,results|
      if geo = results.first
        obj.address1    = geo.street_address
        obj.locality    = geo.city
        obj.postal_code = geo.postal_code
        obj.country     = geo.country #_code
      end
    end


    def geolocation_present?
      latitude && longitude
    end


    #
    # Call a worker process to do the geocoding so we don't wait for the results
    #
    def set_geolocate_method
      self.geolocate_method = 
        if geocoded_address_changed?
          :geocode 
        elsif geolocation_present?
          :reverse_geocode 
        else
          nil
        end
    end


    def do_geolocate
      # geolocate_method will be nil when the record is updated from the queue which is WAD
      LocationJob.new.async.perform(id, self.geolocate_method) if self.geolocate_method
      #binding.pry
    end


    #
    # Return the full string reprentation of all the fields that make up a complete address
    #
    def geocoded_address
      "#{address1} #{address2} #{address3} #{address4} #{locality} #{region} #{postal_code} #{country}"
    end


    #
    # Check the several fields that make up a complete address
    #   Return 'true' if any one of them has changed, otherwise return 'false'
    #
    def geocoded_address_changed?
      rval = (self.address1_changed? or self.locality_changed? or self.region_changed? or self.postal_code_changed? or self.country_changed?)
      logger.debug "Returning a value for location record is modified = #{rval.to_s}"
      rval
    end

    def nearest(list, distance = 10, item = :first)
      self.class.nearest(self, list, distance, item)
    end

    def self.distance_from location1, location2
      location1.distance_to(location2).round(2)
    end

    def self.nearest(point, list, distance = 10, item = :first)
      point = point.location if point.respond_to? :location
      list = list.locations if list.respond_to? :locations
      location = list.near(point, distance, order: :distance).send(item)
      location #? location.locatable : nil
      #binding.pry
    end

    def self.farthest(point, list, distance = 10)
      self.nearest(point, list, distance, :last)
    end
    

  end
end

