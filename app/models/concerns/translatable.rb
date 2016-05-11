module Translatable
  extend ActiveSupport::Concern

  def self.translated(*args)
    args.map{ |a| a.to_sym }
  end

  def insert(attribute, key = :en, str = "")
    raise ArgumentError.new("Attribute must be of type :jsonb. Attribute `#{attribute.to_s}` is of type #{column_for_attribute(attribute).type}.") unless column_for_attribute(attribute).type == :jsonb

    send(attribute.to_s)[key.to_s] = str
    save
  end

  def uniq_keys(attribute)
    return "nope" unless column_for_attribute(attribute).type == :jsonb

    send(attribute.to_s).map{ |k,v| k.to_sym }.flatten
  end
end
