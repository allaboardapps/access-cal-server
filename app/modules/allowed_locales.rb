module AllowedLocales
  EN = "en".freeze
  ES = "es".freeze

  def self.all
    [
      AllowedLocales::EN,
      AllowedLocales::ES
    ]
  end
end
