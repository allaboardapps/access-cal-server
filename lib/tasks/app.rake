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
