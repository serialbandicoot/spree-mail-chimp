class Spree::SubscriptionsController < Spree::BaseController

    def hominid
        @hominid = Hominid::API.new(Spree::Config.get(:mailchimp_api_key), {:secure => true})
    end

    def create

        @return_msg = []

        if params[:email].blank?
            @return_msg << t("missing_email")
        elsif params[:email] !~ /[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i
            @return_msg << t("invalid_email_address")
        else
            begin
                self.class.benchmark "Checking if address exists and/or is valid" do
                    h = hominid
                    list_id =  h.find_list_by_name(Spree::Config.get(:mailchimp_list_id))['id']
                    e_arr = [params[:email]]
                    @mc_member = true if h.list_member_info(list_id, e_arr)['success'] == 1
                end
            rescue
              @return_msg << "Somthing went wrong, please try again later"
            end

            if @mc_member == true then
                @return_msg << t("that_address_is_already_subscribed")
            else
                begin
                    self.class.benchmark "Adding mailchimp subscriber" do
                      h = hominid
                      list_id =  h.find_list_by_name(Spree::Config.get(:mailchimp_list_id))['id']
                      h.list_subscribe(list_id, params[:email], {'FNAME' => '', 'LNAME' => ''}, 'html', false, true, true, false)
                      @return_msg << t("you_have_been_subscribed")
                    end
                rescue #Hominid::ValidationError => e
                    @return_msg << "Somthing went wrong, please try again later"
                end
            end
        end

        respond_to do |format|
            format.js  {render :content_type => 'text/javascripts'}
        end

    end
end
