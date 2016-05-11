module Translatable
  extend ActiveSupport::Concern

  def self.translated(*args)
    args.map(&:to_sym)
  end

  def retrieve(attribute, key)
    raise(ArgumentError, "Attribute must be of type :jsonb. Attribute `#{attribute}` is of type #{column_for_attribute(attribute).type}.") unless column_for_attribute(attribute).type == :jsonb

    str ||= send(attribute.to_s)[key.to_s]
    return send(attribute.to_s)["en"] if str.nil?
    str
  end

  def insert(attribute, key = :en, str = "")
    raise(ArgumentError, "Attribute must be of type :jsonb. Attribute `#{attribute}` is of type #{column_for_attribute(attribute).type}.") unless column_for_attribute(attribute).type == :jsonb

    send(attribute.to_s)[key.to_s] = str
    save
  end

  def uniq_keys(attribute)
    raise(ArgumentError, "Attribute must be of type :jsonb. Attribute `#{attribute}` is of type #{column_for_attribute(attribute).type}.") unless column_for_attribute(attribute).type == :jsonb

    send(attribute.to_s).map { |k, _v| k.to_sym }.flatten
  end
end
