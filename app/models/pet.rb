class Pet < ApplicationRecord

  # Relationships
  # -----------------------------
  belongs_to :owner
  belongs_to :animal
  has_many :visits

  # Scopes
  # -----------------------------
  # order pets by their name
  scope :alphabetical, -> { order('name') }
  # get all the pets we treat (not moved away or dead)
  scope :active, -> { where(active: true) }
  # get all the pets we heave treated that moved away or died
  scope :inactive, -> { where.not(active: true) }
  # alternative ways of doing the inactive scope:
  # scope :inactive, -> { where(active: false) }
  # scope :inactive, -> { where('active = ?', true) }
  # get all the female pets
  scope :females, -> { where(female: true) }
  # get all the male pets
  scope :males, -> {where(female: false) }
  # or 
  # scope :males, -> { where.not(female: true) }

  # get all the pets for a particular owner
  scope :for_owner, ->(owner_id) { where("owner_id = ?", owner_id) }
  # get all the pets who are a particular animal type
  scope :by_animal, ->(animal_id) { where("animal_id = ?", animal_id) }
  # get all the pets born before a certain date
  scope :born_before, ->(dob) { where('date_of_birth < ?', dob) }

  # find all pets that have a name like some term or are and animal like some term
  scope :search, ->(term) { joins(:animal).where('pets.name LIKE ?', "#{term}%").order("pets.name") }

  # Validations
  # -----------------------------
  # First, make sure a name exists
  validates_presence_of :name
  # or
  # validates :name, presence: true, length:{minimum: 3}
  # validates_date :dob, before: 1.years.ago, before_message: "must be at least 1 years old"

  # Custom validations
  # Second, make sure the animal is one of the types PATS treats
  validate :animal_type_treated_by_PATS
  # Third, make sure the owner_id is in the PATS system 
  validate :owner_is_active_in_PATS_system

  # Misc Methods
  # -----------------------------
  # a method to the gender of the pet
  def gender
    return "Female" if self.female
    "Male"
  end  

  # a method to make a Pet inactive
  def make_inactive
      self.active=false
      self.save!
  end

  # a method to make a Pet active
  def make_active
    self.active=true
    self.save!
  end
  
  # Private methods for custom validations and callback handlers
  # -----------------------------
   private
   def animal_type_treated_by_PATS
     # get an array of all animal ids PATS treats
     treated_animal_ids = Animal.all.map{|a| a.id}
    # The map Ruby method:
    #  The way the map method works in Ruby is, it takes an enumerable object, (i.e. the object you call it on), and a block.
    # Then, for each of the elements in the enumerable, it executes the block, passing it the current element as an argument.
    #  The result of evaluating the block is then used to construct the resulting array.
    # An example might make it easier to understand.
    # [1, 2, 3].map { |n| n * 2 } returns [2, 4, 6]
    # In this example, the block (i.e. { |n| n * 2 }) is applied to each element of the initial array (i.e. [1, 2, 3]) in turn, resulting in a new array.
    # more on map: https://mixandgo.com/learn/ruby/map

     # add error unless the animal id of the pet is in the array of possible animal ids
     unless treated_animal_ids.include?(self.animal_id)
       errors.add(:animal, "is an animal type not treated by PATS")
     end
   end
   
   def owner_is_active_in_PATS_system
     # get an array of all active owners in the PATS system
     active_owner_ids = Owner.active.all.map{|o| o.id}
     # add error unless the owner id of the pet is in the array of active owners
     unless active_owner_ids.include?(self.owner_id)
       errors.add(:owner, "is not an active owner in PATS")
     end
   end




end
