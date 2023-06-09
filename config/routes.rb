Rails.application.routes.draw do
  # Tick Tock Task
  devise_for :users, controllers: { registrations: 'users/registrations', sessions: 'users/sessions' }
  delete '/users/sign_out', to: 'users/sessions#destroy'
  resources :user_tasks

  root 'home#index'
  
  # Job application
  resources :job_applications do
    collection do
      post :generate_interview_question
      post :generate_content
    end
  end  
  resources :generated_histories, only: [:index, :create, :show]

  # AI News
  resources :news, only: [:index, :show] do
    member do
      post :translate
    end
  end
  resources :visits, only: [:create]

  resources :npb_news, only: [:index, :show]

  # Code Assistant
  post '/generate', to: 'requests#create'
  get '/capabilities', to: 'capabilities#index'
  post '/detect_available_languages', to: 'code_conversion#detect_available_languages'
  post '/convert_code', to: 'code_conversion#convert_code'


end
