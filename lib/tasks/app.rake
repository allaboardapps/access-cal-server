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
end
