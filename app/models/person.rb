class Person < ActiveRecord::Base

  belongs_to :account

  validates :name, :age, :account, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  
end
