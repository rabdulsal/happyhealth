HappyHealth::Application.routes.draw do

  captcha_route

  # get "users/show" => 'users#show'

  resources :notes

  get '/users/sign_up' => 'static_pages#home'
  
  root to: "static_pages#home"

  get "/help" => 'static_pages#help'
  get "/about" => 'static_pages#about'

  post "/agree" => "offices#save_receipt", as: :receipt

  devise_for :users

  resources :users do
    resources :notes
    resources :forms
    resources :appointments
  end

  resources :offices do
    resources :pdfs
  end

  #Yelp Office Search
  match "/yelp" => "offices#yelp_search"
  

  # InsuranceQuery GET resources & requests
  resources :insurance_queries do
    #get 'eligibility', on: :collection
    get 'eligibility', on: :member
    put 'service', on: :member
  end

  #********************** DOWNLOAD PDF BUTTON ****************************

  get "/appointment/download/:appointment_id" => 'appointments#show_pdf', :as => :pdf
  get "/office/download/:office_id" => 'offices#show_pdf', :as => :office_pdf

  #########################################################################
  # AJAX get requests
  get "/appointment/doctors" => 'appointments#get_doctors'
  get "/appointment/pdf" => 'appointments#get_pdf'
  #########################################################################

  get "/doctors" => 'appointments#doctors', :as => :doctors

  match "/officeforms/new" =>'pdfs#new'
end
