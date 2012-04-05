Spree::Core::Engine.routes.append do

    resources :subscriptions, :only => :create

    namespace :admin do
        resource  :mail_chimp_settings
    end  

end
