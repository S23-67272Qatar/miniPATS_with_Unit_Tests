class Animal < ApplicationRecord

  # Callbacks
  # -----------------------------
  before_save :capitalize_name
  # after_create :make_active
  # after_save :make_active

  # Relationships
  # -----------------------------
  has_many :pets

   # Scopes
   # -----------------------------
   scope :alphabetical, -> { order('name') }
   scope :active,       -> { where(active: true) }
   scope :inactive,     -> { where(active: false) }

  # Validations
  # -----------------------------
  validates_presence_of :name
  validates :name, uniqueness: true
  # Or
  validates_uniqueness_of :name, message:"Animal already in the records"

  # Make sure the animal name contains more than 2 letters 
  validates :name, length:{ minimum: 2}

  # Private methods for custom validations and callback handlers
  # -----------------------------
  private 

  def capitalize_name
    self.name.capitalize!
  end

  # def make_active
  #   self.active=true
  # end
    

end
