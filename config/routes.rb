Morsbox::Application.routes.draw do
  devise_for :admins, :controllers => {:registrations => "admin/registrations" }
  
  namespace 'admin' do
    resources :index
    resources :static_blocks, :except => [:new, :create, :show]
    root :to => "index#index"
  end

  resources :sections, :only => :show
  resources :projects, :only => :show
  resources :contacts, :only => [:index, :create]
  root :to => "pages#index"
end

ActionDispatch::Routing::Translator.translate_from_file('config','i18n-routes.yml')