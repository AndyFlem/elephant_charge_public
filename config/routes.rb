
Rails.application.routes.draw do
  root 'application#index'

  #standard index routes
  get 'teams', to: 'teams#index'
  get 'charges', to: 'charges#index'
  get 'sponsors', to: 'sponsors#index'
  get 'beneficiaries', to: 'beneficiaries#index'
  get 'cars', to: 'cars#index'

  #charge by year
  get ':id', constraints: {id: /\d{4}/}, to: 'charges#show'

  #team by name (ref)
  get ':id', to: 'teams#show'

  #team by name (ref)
  get 'teams/:id', to: 'teams#show'
  get 'team/:id', to: 'teams#show'

  #charge by year
  get 'charges/:id', to: 'charges#show'
  get 'charge/:id', to: 'charges#show'

  #beneficiary by name (ref)
  get 'beneficiaries/:id', to: 'beneficiaries#show'
  get 'beneficiary/:id', to: 'beneficiaries#show'

  #sponsor by name (ref)
  get 'sponsors/:id', to: 'sponsors#show'
  get 'sponsor/:id', to: 'sponsors#show'

  get 'cars/:id', to: 'cars#show'
  get 'car/:id', to: 'cars#show'
end

