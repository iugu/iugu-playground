class Person < ActiveRecord::Base

  belongs_to :account

  validates :name, :age, :account, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }

  attr_accessible :name, :age, :notes

  has_paper_trail
  
  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(options)
    tire.search do
      query { string "*#{options[:query]}*", :default_operator => 'AND' } unless options[:query].blank?

      from options[:start] unless options[:start].blank?
      size options[:limit] unless options[:limit].blank?
      filter :term, account_id: options[:account_id] unless options[:account_id].blank?

      facet "age" do
        terms :age
      end
      
      sort { 
        options[:sortBy].each do |k, v|
          by k.downcase, v.downcase unless v.blank?
        end
      } unless options[:sortBy].blank?
    end
  end

  mapping do
    indexes :id,  type: 'integer'
    indexes :name, type: 'string'
    indexes :age, type: 'integer'
  end

end
