module Contexts

  def create_owners
    @alex = FactoryBot.create(:owner)
    @rachel = FactoryBot.create(:owner, first_name: "Rachel", active: false)
    @mark = FactoryBot.create(:owner, first_name: "Mark", phone: "412-268-8211")
  end
  
  def destroy_owners
    @rachel.delete
    @mark.delete
    @alex.delete
  end

  def create_animals
    @cat    = FactoryBot.create(:animal)
    @dog    = FactoryBot.create(:animal, name: 'Dog')
    @bird   = FactoryBot.create(:animal, name: 'Bird')
    @ferret = FactoryBot.create(:animal, name: 'Ferret')
    @rabbit = FactoryBot.create(:animal, name: 'Rabbit')
    @turtle = FactoryBot.create(:animal, name: 'Turtle', active: false)
  end
  
  def destroy_animals
    @cat.delete  
    @dog.delete
    @bird.delete
    @ferret.delete
    @rabbit.delete
    @turtle.delete
  end

  def create_pets
    @dusty = FactoryBot.create(:pet, animal: @cat, owner: @alex, female: false)
    @polo = FactoryBot.create(:pet, animal: @cat, owner: @alex, name: "Polo", active: false)
    @pork_chop = FactoryBot.create(:pet, animal: @dog, owner: @mark, name: "Pork Chop")
  end
  
  def destroy_pets
    @dusty.delete
    @polo.delete
    @pork_chop.delete
  end
  
  def create_visits
    @visit1 = FactoryBot.create(:visit, pet: @dusty)
    @visit2 = FactoryBot.create(:visit, pet: @polo, date: 5.months.ago.to_date)
    @visit3 = FactoryBot.create(:visit, pet: @polo, date: 2.months.ago.to_date)    
  end
  
  def destroy_visits
    @visit1.delete
    @visit2.delete
    @visit3.delete
  end

  # CREATE ALL THE TEST ENTITIES
  
  def create_all

    create_animals
    puts "Built animals"
    create_owners
    puts "Built owners and owner users"
    create_pets
    puts "Built pets"
    create_visits
    puts "Built visits"

  end
  
end