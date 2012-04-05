class Spree::Admin::MailChimpSettingsController < Spree::Admin::BaseController

  respond_to :html

  def update
    Spree::Config.set(params[:preferences])
    
    respond_to do |format|
      format.html {
        redirect_to admin_mail_chimp_settings_path
      }
    end
  end

end
