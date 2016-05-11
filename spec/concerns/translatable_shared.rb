require "rails_helper"

shared_examples "translatable" do
  let(:model) { described_class }

  describe ".retrieve" do
    xit "renders the value associated with the key provided" do

    end

    xit "renders the default value associated with the default key if no value associated with key provided" do

    end

    xit "raises an error if method call is conducted on a datatype that is not jsonb" do

    end
  end

  describe ".insert" do
    it "creates a jsonb key/value on the model attribute" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: "This is English" })
      chinese_title = "This is Chinese"
      instance_of_class.insert(:title, :cn, chinese_title)
      expect(instance_of_class.title["cn"]).to eq chinese_title
    end

    it "updates a jsonb key/value on the model attribute" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: "This is English" })
      new_english_title = "This is different English"
      instance_of_class.insert(:title, :en, new_english_title)
      expect(instance_of_class.title["en"]).to eq new_english_title
    end

    it "raises an error if an insert is attempted on non-jsonb datatype" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      english_title = "This is English"
      expect{ instance_of_class.insert(:name, :en, english_title) }.to raise_error(ArgumentError)
    end

    xit "raises an error if an insert is attempted on non-declared key" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      expect(instance_of_class.title).to be_truthy
    end

    xit "does not raise an error if no declared keys exist" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      expect(instance_of_class.title).to be_truthy
    end

    xit "updates a key/value if the attribute is submitted as a string" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      expect(instance_of_class.title).to be_truthy
    end

    xit "updates a key/value if the attribute is submitted as a symbol" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      expect(instance_of_class.title).to be_truthy
    end

    xit "creates a key/value if the attribute is submitted as a string" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      expect(instance_of_class.title).to be_truthy
    end

    xit "creates a key/value if the attribute is submitted as a symbol" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      expect(instance_of_class.title).to be_truthy
    end
  end

  describe ".uniq_keys" do
    xit "lists all keys that exist for jsonb attribute" do

    end

    xit "raises an error if submitted attribute is not jsonb datatype" do

    end
  end
end
