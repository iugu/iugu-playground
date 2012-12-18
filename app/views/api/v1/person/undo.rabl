object false
node(:id) { |m| @person.id }
node(:age) { |m| @person.age }
node(:created_at) { |m| @person.created_at }
node(:updated_at) { |m| @person.updated_at }
node(:name) { |m| @person.name }
node(:notes) { |m| @person.notes }
node(:undo_event) { |m| @version.event  }
