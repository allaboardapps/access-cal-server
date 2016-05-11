require "rails_helper"

shared_examples "translatable" do
  let(:model) { described_class }

  describe ".retrieve" do
    it "renders the value associated with the key provided" do
      chinese_title = "这是中国"
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence, cn: chinese_title })
      expect(instance_of_class.retrieve(:title, :cn)).to eq chinese_title
    end

    it "renders the default value associated with the default key if no value associated with key provided" do
      english_title = Faker::Hipster.sentence
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: english_title })
      expect(instance_of_class.retrieve(:title, :cn)).to eq english_title
    end

    it "raises an error if method call is conducted on a datatype that is not jsonb" do
      english_title = Faker::Hipster.sentence
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: english_title })
      expect { instance_of_class.retrieve(:name, :en) }.to raise_error(ArgumentError)
    end
  end

  describe ".insert" do
    it "creates a jsonb key/value on the model attribute" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence })
      chinese_title = "这是中国"
      instance_of_class.insert(:title, :cn, chinese_title)
      expect(instance_of_class.title["cn"]).to eq chinese_title
    end

    it "updates a jsonb key/value on the model attribute" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence })
      new_english_title = Faker::Hipster.sentence
      instance_of_class.insert(:title, :en, new_english_title)
      expect(instance_of_class.title["en"]).to eq new_english_title
    end

    it "raises an error if an insert is attempted on non-jsonb datatype" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      english_title = Faker::Hipster.sentence
      expect { instance_of_class.insert(:name, :en, english_title) }.to raise_error(ArgumentError)
    end

    xit "raises an error if an insert is attempted on non-declared key" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      expect(instance_of_class.title).to be_truthy
    end

    xit "does not raise an error if no declared keys exist" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym)
      expect(instance_of_class.title).to be_truthy
    end

    it "updates a key/value if the attribute is submitted as a string" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence })
      new_english_title = Faker::Hipster.sentence
      instance_of_class.insert("title", :en, new_english_title)
      expect(instance_of_class.title["en"]).to eq new_english_title
    end

    it "updates a key/value if the attribute is submitted as a symbol" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence })
      new_english_title = Faker::Hipster.sentence
      instance_of_class.insert(:title, :en, new_english_title)
      expect(instance_of_class.title["en"]).to eq new_english_title
    end

    it "updates a key/value if the key is submitted as a string" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence })
      new_english_title = Faker::Hipster.sentence
      instance_of_class.insert(:title, "en", new_english_title)
      expect(instance_of_class.title["en"]).to eq new_english_title
    end

    it "updates a key/value if the key is submitted as a symbol" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence })
      new_english_title = Faker::Hipster.sentence
      instance_of_class.insert(:title, :en, new_english_title)
      expect(instance_of_class.title["en"]).to eq new_english_title
    end

    it "creates a key/value if the attribute is submitted as a string" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence })
      spanish_title = Faker::Hipster.sentence
      instance_of_class.insert("title", :es, spanish_title)
      expect(instance_of_class.title["es"]).to eq spanish_title
    end

    it "creates a key/value if the attribute is submitted as a symbol" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence })
      spanish_title = Faker::Hipster.sentence
      instance_of_class.insert(:title, :es, spanish_title)
      expect(instance_of_class.title["es"]).to eq spanish_title
    end
  end

  describe ".uniq_keys" do
    it "lists all keys that exist for jsonb attribute" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence, cn: "这是中国" })
      expect(instance_of_class.uniq_keys(:title)).to eq [:en, :cn]
    end

    it "raises an error if method call is conducted on a datatype that is not jsonb" do
      instance_of_class = FactoryGirl.create(model.to_s.underscore.to_sym, title: { en: Faker::Hipster.sentence, cn: "这是中国" })
      expect { instance_of_class.uniq_keys(:name) }.to raise_error(ArgumentError)
    end
  end
end
