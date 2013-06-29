class Person < ActiveRecord::Base

  belongs_to :account

  validates :name, :age, :account, presence: true
  validates :age, numericality: { only_integer: true, greater_than: 0 }
  validates :gender, inclusion: { in: %w(male female) , message: "%{value} is not a valid gender" }

  attr_accessible :name, :age, :notes, :gender

  has_paper_trail
  
  include Tire::Model::Search
  include Tire::Model::Callbacks

  def self.search(options = {})
    created_at_range = {}
    created_at_range.merge! from: options[:created_at_from] unless options[:created_at_from].blank?
    created_at_range.merge! to: options[:created_at_to] unless options[:created_at_to].blank?

    tire.search do
      query { string "*#{options[:query]}*", :default_operator => 'AND' } unless options[:query].blank?

      query { 
        range :created_at, created_at_range
      } unless created_at_range.blank?

      from options[:start] unless options[:start].blank?
      size options[:limit] unless options[:limit].blank?
      filter :term, account_id: options[:account_id] unless options[:account_id].blank?

      filter :terms, age: options[:age_filter] unless options[:age_filter].blank?
      filter :terms, gender: options[:gender_filter] unless options[:gender_filter].blank?

      facet "age" do
        terms :age
      end

      facet "gender" do
        terms :gender
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
    indexes :account_id, type: 'string', analyzer: 'whitespace'
    indexes :notes, type: 'string', analyzer: 'snowball'
    indexes :created_at, type: 'date'
    indexes :gender, type: 'string'
  end

end
