class window.app.People extends Backbone.Collection
  url: 'api/v1/people'
  model: Person

class window.app.Person extends window.app.BaseResource
  virtual_attributes: ['account_id', 'id', 'created_at', 'updated_at']
