Morsbox::Application.routes.draw do
  devise_for :admins
  
  namespace 'admin' do
    root :to => "index#index"
  end

  resources :sections, :only => :show
  root :to => "pages#index"
end

ActionDispatch::Routing::Translator.translate_from_file('config','i18n-routes.yml')