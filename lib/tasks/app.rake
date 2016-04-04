namespace :app do
  desc "Rebuild db with drop, create, migrate, test:prepare (dev and staging only)"
  task rebuild: :environment do
    input = ''
    STDOUT.puts "Drop, recreate, and migrate app database? y[es] or n[o]"
    input = STDIN.gets.chomp
    if input == "y" && (Rails.env.development? || Rails.env.staging?)
      Rake::Task["db:drop"].execute
      Rake::Task["db:create"].execute
      Rake::Task["db:migrate"].execute
      Rake::Task["db:test:prepare"].execute
    else
      puts "Aborting app:rebuild tasks"
    end
  end

  desc "Rebuild db with drop, create, migrate, SEED, and test:prepare (dev and staging only)"
  task rebuild_seed: :environment do
    input = ''
    STDOUT.puts "Drop, recreate, migrate, seed, and prepare testing app database? y[es] or n[o]"
    input = STDIN.gets.chomp
    if input == "y" && (Rails.env.development? || Rails.env.staging?)
      Rake::Task["db:drop"].execute
      Rake::Task["db:create"].execute
      Rake::Task["db:migrate"].execute
      Rake::Task["db:seed"].execute
      Rake::Task["db:test:prepare"].execute
    else
      puts "Aborting app:rebuild tasks"
    end
  end

  desc "Post-deployment and promotion processes"
  task release: :environment do
    Rake::Task["db:migrate"].execute
  end

  desc "load default tags"
  task load_default_tags: :environment do
    Tag.create name: "accessible entrances", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "accessible parking", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "accessible pathways", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "accessible restroom", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "air-conditioned", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "asl interpretation", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "assistive listening systems", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "audio description", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "audio version and taping", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "autism-friendly", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "braille material", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "closed captioning", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "communication access in real time", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "dietary options", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "large print", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "open captioning", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "reserved seating", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "service animal accomodations", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "touch tour", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "wheelchair or scooter accessible", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "wheelchair or scooter available", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ACCESSIBILITY
    Tag.create name: "banquet", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "board meeting", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "celebration", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "colloquium", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "conclave", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "conference", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "congress", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "convention", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "gala", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "meeting", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "performance", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "seminar", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "symposium", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "trade show", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "training", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "workshop", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::ASSEMBLY
    Tag.create name: "art", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "athletics", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "awards", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "comedy", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "concert", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "dance", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "education or class", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "fair or festival", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "film", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "food or drink", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "fundraiser", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "gallery or museum", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "holiday", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "kids or family", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "lecture", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "literature", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "music", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "networking", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "political", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "religious", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "shopping", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "social good", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "team building", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "theater", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
    Tag.create name: "tour", tag_type: TagTypes::DEFAULT, tag_category: TagCategories::CONTENT
  end

  desc "set fastly cors headers to fix chrome/firefox font loading issues"
  task allow_cors: :environment do
    require "yajl"
    require "excon"

    # check for the Cors Allow header
    versions = Yajl.load(Excon.get("https://api.fastly.com/service/#{ENV['FASTLY_SERVICE_ID']}/version",
      :headers => {'Fastly-Key'=>ENV['FASTLY_API_KEY']}).body)
    last_version = versions.last['number']

    exists = Excon.get("https://api.fastly.com/service/#{ENV['FASTLY_SERVICE_ID']}/version/#{last_version}/header/Cors%20Allow",
      :headers => {'Fastly-Key'=>ENV['FASTLY_API_KEY']}).status

    if(exists == 200)
      puts "Allow Cors already set. Done."
    else
      cloned = Yajl.load(Excon.put("https://api.fastly.com/service/#{ENV['FASTLY_SERVICE_ID']}/version/#{last_version}/clone",
        :headers => {'Fastly-Key'=>ENV['FASTLY_API_KEY']}).body)
      cloned_version = cloned['number']
      puts cloned

      response = Yajl.load(Excon.post("https://api.fastly.com/service/#{ENV['FASTLY_SERVICE_ID']}/version/#{cloned_version}/header",
        :headers => {'Fastly-Key'=>ENV['FASTLY_API_KEY']},
        :body => 'name=Cors Allow&type=response&action=set&dst=http.Access-Control-Allow-Origin&src="*"&ignore_if_set=0&priority=10').body)
      puts response

      activated = Excon.put("https://api.fastly.com/service/#{ENV['FASTLY_SERVICE_ID']}/version/#{cloned_version}/activate",
        :headers => {'Fastly-Key'=>ENV['FASTLY_API_KEY']}).status
      if(activated == 200)
        puts "Allow Cors header set. Done."
      end
    end
  end

  # desc "Load External CSV"
  # task load_external_csv: :environment do
  #   puts "BEGIN: Adding External Data"

  #   csv_text = open(AppSettings.external_url)
  #   csv = CSV.parse(csv_text, headers: true)
  #   csv.each do |row|
  #     model = Model.create_with(
  #       id: row["id"]
  #     ).find_or_create_by(
  #       id: row["id"]
  #     )
  #   end
  #   puts "END:   Adding External Data"
  # end
end
