module TagTypes
  DEFAULT = "default".freeze
  CLIENT = "client".freeze
  CONSUMER = "consumer".freeze

  def self.system
    [TagTypes::DEFAULT]
  end

  def self.client
    [TagTypes::CLIENT]
  end

  def self.consumer
    [TagTypes::CONSUMER]
  end

  def self.all
    self.system.concat(self.client).concat(self.consumer).sort
  end
end
