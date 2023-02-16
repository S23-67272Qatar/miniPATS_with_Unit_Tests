namespace :db do
    desc "Erase and fill database"
    # creating a rake task within db namespace called 'populate'
    # executing 'rake db:populate' will cause this script to run
    task :populate => :environment do
      # Step 0: initial set-up
      # Drop the old db and recreate from scratch
      Rake::Task['db:drop'].invoke
      Rake::Task['db:create'].invoke
      # Invoke rake db:migrate to set up db structure based on latest migrations
      Rake::Task['db:migrate'].invoke
      
      # Get the faker gem (see docs at http://faker.rubyforge.org/rdoc/)
      require 'faker' 


      # -----------------------    
      # Step 2: add some animal types to work with (small set for now...)
      animals = %w[Bird Cat Dog Ferret Rabbit]
      animals.sort.each do |animal|
        a = Animal.new
        a.name = animal
        a.active = true
        a.save!
      end
      # get an array of animal_ids to use later
      animal_ids = Animal.all.map{|a| a.id}
      
      
      # -----------------------
      # Step 1: add 50 owners to the system and associated pets
      20.times do 
        owner = Owner.new

        # get some fake data using the Faker gem
        owner.first_name = Faker::Name.first_name
        owner.last_name = Faker::Name.last_name
        owner.street = Faker::Address.street_address
        owner.city = "Pittsburgh"
        # assume PA since this is a Pittsburgh vet office
        owner.state = "PA"
        # randomly assign one of Pgh area zip codes
        owner.zip = ["15213", "15212", "15203", "15237", "15222", "15219", "15217", "15224"].sample
        # want to store phone as 10 digits in db and use rails helper
        # number_to_phone to format it properly in views
        owner.phone = rand(10 ** 10).to_s.rjust(10,'0')
        owner.email = "#{owner.first_name.downcase}.#{owner.last_name.downcase}@example.com"
        # assume all the owners still have living pets
        owner.active = true
        owner.save!
      end
      # an array of all owner ids
      all_owner_ids = Owner.all.to_a.map{|o| o.id}
      puts "Owner count: #{all_owner_ids.count}"
      
      # Step 2: Give each owner 1 to 3 pets
      all_owner_ids.each do |oid| 
        num_pets = rand(3) + 1
        pet_names = %w[Sparky Dusty Caspian Lucky Fluffy Snuggles Snuffles Dakota Montana Cali Polo Buddy Mambo Pickles Pork\ Chop Fang Zaphod Yeller Groucho Meatball BJ CJ TJ Buttercup Bull Bojangles Copper Fozzie Nipper Mai\ Tai Bongo Bama Spot Tango Tongo Weeble].shuffle
        num_pets.times do 
          pet = Pet.new
          # assign the owner
          pet.owner_id = oid
          # give the pet a unique name from shuffled list of typical pet names
          pet.name = pet_names.pop
          # assign an animal id from ones created earlier
          pet.animal_id = animal_ids.sample
          # randomly assign female status
          pet.female = [true, false].sample

          pet.active = [true, false].sample
          # pick a DOB at random ranging 30 days ago (newborn) to 12 years old
          pet.date_of_birth = (30..4400).to_a.sample.days.ago
          # now save the object
          pet.save!
        end
      end  
      all_pets = Pet.all.to_a
      puts "Pet count: #{all_pets.count}"
   
      # Step 7: add between 1 to 5 visits for each pet
      all_pets.each do |pet|
        num_visits = rand(5) + 1
        num_visits.times do
          visit = Visit.new
          visit.pet_id = pet.id
          # set the visit to sometime between DOB and the present
          visit.date = Faker::Time.between(from: pet.date_of_birth, to: Date.today).to_date
          # different animals fall in different weight ranges so we need
          # to find the right range of weights for the visiting pet
          case pet.animal_id
            when 1  # birds tend to be between 1 & 2 pounds
              weight_range = (1..2) 
            when 2  # cats 
              weight_range = (5..15)
            when 3  # dogs
              weight_range = (10..60)
            when 4  # ferrets
              weight_range = (1..6)
            when 5  # rabbits
              weight_range = (2..7)
          end
          # now assign the pet a weight within the range
          visit.weight = weight_range.to_a.sample
          visit.save!
        end
      end
  
      all_visit_ids = Visit.all.map(&:id)
      puts "Visit count: #{all_visit_ids.count}"

    end
  end
  