class window.app.Person extends window.app.BaseResource
  urlRoot: 'api/v1/people'
  virtual_attributes: ['account_id', 'id', 'created_at', 'updated_at']
  collection: window.app.People

class window.app.People extends Backbone.Collection
  url: 'api/v1/people'
  model: window.app.Person
