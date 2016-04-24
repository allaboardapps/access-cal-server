require "rails_helper"

describe AllowedLocales, type: :module do
  it "renders a locale" do
    expect(described_class::ES).to eq "es"
  end

  it "returns a list of all locales" do
    expect(described_class.all).to include "es", "en"
  end
end
