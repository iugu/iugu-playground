class Person < ActiveRecord::Base

  belongs_to :account

  valites :name, :age, :account, presence: true
  valites :age, numericality: { only_integer: true, greater_than: 0 }
  
end
