module Wowo::Guid
  def self.included(model)
    model.class_eval do
      before_create :set_guid
      #xml_attr :guid
    end
  end
  def set_guid
    self.guid ||= ActiveSupport::SecureRandom.hex(12) #default is 16 hence generate 32 bytes
  end
end