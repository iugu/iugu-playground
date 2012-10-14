require IuguSDK::Engine.root.join('app', 'models', 'account')

class Account
  has_many :persons, dependent: :destroy
end
