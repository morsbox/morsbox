Morsbox::Application.routes.draw do
  devise_for :admins, :controllers => {:registrations => "admin/registrations" }
  
  namespace 'admin' do
    resources :index
    root :to => "index#index"
  end

  resources :sections, :only => :show
  resources :projects, :only => :show
  match "contacts" => "pages#contacts"
  root :to => "pages#index"
end

ActionDispatch::Routing::Translator.translate_from_file('config','i18n-routes.yml')