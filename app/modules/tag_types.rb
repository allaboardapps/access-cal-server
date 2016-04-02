module TagTypes
  DEFAULT = "default"
  CLIENT = "client"
  CONSUMER = "consumer"

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
    self.system.concat(self.system).concat(self.client).concat(self.consumer).sort
  end
end
