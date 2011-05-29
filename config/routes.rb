Morsbox::Application.routes.draw do
  
  root :to => "pages#index"
end

ActionDispatch::Routing::Translator.translate_from_file('config','i18n-routes.yml')