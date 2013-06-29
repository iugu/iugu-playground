class window.app.Person extends window.app.BaseResource
  urlRoot: '/api/v1/people'

  virtual_attributes: ['account_id', 'id', 'created_at', 'updated_at', 'undo_event']

  collection: window.app.People

  validation:
    name:
      required: true
    gender:
      oneOf: ["male", "female"]
    age:
      range: [1, 150]

class window.app.People extends window.app.BaseResources
  model: window.app.Person

  paginator_core:
    url: '/api/v1/people?&'
    dataType: 'json'
