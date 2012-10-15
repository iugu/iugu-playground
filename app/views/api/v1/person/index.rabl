node :items do
  collection @people, :object_root => false
end
attributes :id, :age, :created_at, :updated_at, :name, :notes
node :totalItems do
  @totalItems
end
