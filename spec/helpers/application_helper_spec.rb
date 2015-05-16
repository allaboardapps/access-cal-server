require "rails_helper"

describe ApplicationHelper, type: :helper do
  describe "#copyright_notice" do
    it "renders the current year in the Copyright notice" do
      current_year = Time.new.strftime "%Y"
      expect(copyright_notice).to eq "&copy; #{current_year} Events Server. All Rights Reserved"
    end
  end

  describe "#number_with_leading" do
    it "coverts integer into string with leading zero if necessary" do
      [0,1,2,3,4,5,6,7,8,9].each do |num|
        expect(number_with_leading(num)).to eq "0#{num}"
      end
    end

    it "does not covert multi-digit integers to strings with leading zero" do
      [10,100,20000,300000].each do |num|
        expect(number_with_leading(num)).to eq "#{num}"
      end
    end
  end
end
