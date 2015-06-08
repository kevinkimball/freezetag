module FreezeTag

  API_ENDPOINT = 'https://www.freezetag.io/api/v1/tags'

  mattr_accessor :api_key

  def self.initialize(options = {})
    self.api_key = options[:api_key]
  end

  def self.included(base)
    base.class_eval do
      extend ClassMethods
      include InstanceMethods
      cattr_accessor :freezetag_attribute, :freezetag_api_key
    end
    base.freezetag_api_key = self.api_key
  end

  module ClassMethods
    def autocomplete(attribute)
      self.freezetag_attribute = attribute
      after_save :freezetag_index_record
      before_destroy :freezetag_deindex_record
    end
  end

  module InstanceMethods
    def freezetag_index_record
      body = { name: self.send(self.freezetag_attribute), type: self.class.name, id: self.id }
      HTTParty.post(API_ENDPOINT, headers: { 'X-API-Key' => self.freezetag_api_key }, body: body)
    end

    def freezetag_deindex_record
      body = { type: self.class.name, id: self.id }
      HTTParty.delete(API_ENDPOINT, headers: { 'X-API-Key' => self.freezetag_api_key }, body: body)
    end
  end

end
