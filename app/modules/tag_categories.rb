module TagCategories
  ACCESSIBILITY = "accessibility".freeze
  ASSEMBLY = "assembly".freeze
  CONTENT = "content".freeze

  def self.all
    [
      TagCategories::ACCESSIBILITY,
      TagCategories::ASSEMBLY,
      TagCategories::CONTENT
    ]
  end
end
