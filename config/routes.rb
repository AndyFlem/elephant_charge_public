
Rails.application.routes.draw do
  root 'application#index'

  #standard index routes
  get 'teams', to: 'teams#index'
  get 'charges', to: 'charges#index'
  get 'sponsors', to: 'sponsors#index'
  get 'beneficiaries', to: 'beneficiaries#index'
  get 'cars', to: 'cars#index'

  #JSON STUFF
  get ':id/guards',constraints: {id: /\d{4}/}, to: 'guards#json_index'
  get ':id/entries',constraints: {id: /\d{4}/}, to: 'entries#json_index'
  get 'entry/:entry_id',to: 'entries#json_show'
  get 'entry_legs/:entry_id', to: 'entry_legs#json_index'

  #charge by year
  get ':id', constraints: {id: /\d{4}/}, to: 'charges#show'

  #team by name (ref)
  get ':ref', to: 'teams#show'

  #entry by year and team
  get ':id/:ref',constraints: {id: /\d{4}/}, to: 'entries#show'

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

  #cars by id
  get 'cars/:id', to: 'cars#show'
  get 'car/:id', to: 'cars#show'


end

