module TagCategories
  ACCESSIBILITY = "accessibility"
  ASSEMBLY = "assembly"
  CONTENT = "content"

  def self.all
    [
      TagCategories::ACCESSIBILITY,
      TagCategories::ASSEMBLY,
      TagCategories::CONTENT
    ]
  end
end
