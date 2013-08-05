HappyHealth::Application.routes.draw do

  get "blue_button/receive_attachment"

  captcha_route

  # get "users/show" => 'users#show'

  resources :notes

  get '/users/sign_up' => 'static_pages#home'

  root to: "static_pages#home"

  get "/help" => 'static_pages#help'
  get "/about" => 'static_pages#about'

  post "/agree" => "offices#save_receipt", as: :receipt

  get "/add_medication" => 'forms#add_medication', as: :add_medication
  get "/remove_medication" => 'forms#remove_medication', as: :remove_medication
  get "/add_allergy" => 'forms#add_allergy', as: :add_allergy
  get "/remove_allergy" => 'forms#remove_allergy', as: :remove_allergy
  get "/add_problem" => 'forms#add_problem', as: :add_problem
  get "/remove_problem" => 'forms#remove_problem', as: :remove_problem

  devise_for :users

  resources :users do
    resources :notes
    resources :forms do
      member do
        get 'printout'
      end
    end
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

  get "/appointment/download/:appointment_id" => 'offices#show', :as => :pdf
  get "/office/download/:office_id" => 'offices#show_pdf', :as => :office_pdf

  #########################################################################
  # AJAX get requests
  get "/appointment/doctors" => 'appointments#get_doctors'
  get "/appointment/pdf" => 'appointments#get_pdf'
  #########################################################################

  get "/doctors" => 'appointments#doctors', :as => :doctors

  match "/officeforms/new" =>'pdfs#new'

  # BlueButton Direct CCDA Attachment Routing
  post "/incoming/ccda/for/:to" => 'bluebutton#attachment'

end
