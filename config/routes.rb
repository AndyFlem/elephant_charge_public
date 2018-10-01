
Rails.application.routes.draw do
  root 'application#index'

  get 'sitemap.xml', :to => 'application#sitemap', :defaults => {:format => 'xml'}


  #search
  get 'search', to: 'search#search'

  #flat pages
  get 'about', to: 'application#about'
  get 'contact', to: 'application#contact'
  get 'rules', to: 'application#rules'
  get 'privacy', to: 'application#privacy'
  get 'getinvolved', to: 'application#getinvolved'
  get 'compare', to: 'teams#compare'

  #awards
  get 'awards', to: 'application#awards'

  #newsletters
  get 'newsletters', to: 'campaigns#index'

  #standard index routes
  get 'teams', to: 'teams#index'
  get 'charges', to: 'charges#index'
  #get 'sponsors', to: 'sponsors#index'
  get 'beneficiaries', to: 'beneficiaries#index'

  #cars
  get 'cars', to: 'cars#index'
  get 'car/:ref', to: 'cars#show'

  #photos
  get 'photo/:id', to: 'photos#show'
  get 'admin/photo_views', to: 'photos#views'
  get 'photos', to: 'photos#index'

  #JSON STUFF
  get ':id/guards',constraints: {id: /\d{4}/}, to: 'guards#json_index'
  get ':id/entries',constraints: {id: /\d{4}/}, to: 'entries#json_index'
  get 'entry/:entry_id',to: 'entries#json_show'
  get 'entry_legs/:entry_id', to: 'entry_legs#json_index'
  get 'leg/:leg_id',to: 'legs#json_show'

  #charge by year
  get ':id', constraints: {id: /\d{4}/}, to: 'charges#show'

  #charge team list
  get ':id/teams', constraints: {id: /\d{4}/}, to: 'entries#index'

  #charge photos
  get ':id/photos', constraints: {id: /\d{4}/}, to: 'charges#photos'


  #team by name (ref)
  get ':ref', to: 'teams#show'
  get ':ref/photos', to: 'teams#photos'
  #team compare
  get 'compare/:teamone/:teamtwo', to: 'teams#compare'


  #entry by year and team
  get ':id/:ref',constraints: {id: /\d{4}/}, to: 'entries#show'
  get ':id/:ref/photos',constraints: {id: /\d{4}/}, to: 'entries#photos'


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

