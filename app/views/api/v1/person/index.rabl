object false
child(@items => "items") do
  attributes :account_id, :age, :created_at, :id, :name, :notes, :updated_at
end
glue :facets do
  child @facets => "facets" do
    @people.facets.each do |f|
      attribute f.first.to_sym
    end
  end
end
node(:totalItems) { @totalItems }
