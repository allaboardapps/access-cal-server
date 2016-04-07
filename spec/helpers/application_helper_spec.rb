require "rails_helper"

describe ApplicationHelper, type: :helper do
  describe "#copyright_notice" do
    it "renders the current year in the Copyright notice" do
      expect(copyright_notice).to eq "&copy; 2016 Access Cal"
    end
  end

  describe "#number_with_leading" do
    it "coverts integer into string with leading zero if necessary" do
      [0, 1, 2, 3, 4, 5, 6, 7, 8, 9].each do |num|
        expect(number_with_leading(num)).to eq "0#{num}"
      end
    end

    it "does not covert multi-digit integers to strings with leading zero" do
      [10, 100, 20_000, 300_000].each do |num|
        expect(number_with_leading(num)).to eq num.to_s
      end
    end
  end
end
