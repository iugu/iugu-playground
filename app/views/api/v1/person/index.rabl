object false
child(@people => "items") do
  attributes :account_id, :age, :created_at, :id, :name, :notes, :updated_at
end
node(:totalItems) { @totalItems }
