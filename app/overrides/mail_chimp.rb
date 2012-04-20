Deface::Override.new(:virtual_path  => "spree/admin/configurations/index",
                     :name          => "mailchimp_settings",
                     :insert_bottom => "[data-hook='admin_configurations_menu'], #admin_configurations_menu[data-hook]",
                     :text          => %q{
                                          <tr>
                                              <td><%= link_to t("mailchimp_settings"), admin_mail_chimp_settings_path %></td>
                                              <td><%= t("mailchimp_settings_description") %></td>
                                          </tr>
                                        })

Deface::Override.new(:virtual_path => "spree/shared/_user_form",
                     :name => "converted_signup_below_password_fields",
                     :insert_before => "[data-hook='signup_below_password_fields'], #signup_below_password_fields[data-hook]",
                     :text => %q{
                                <p class="login_newsletter_subscribe">
                                  <%= check_box :user, :is_mail_list_subscriber, :class => 'title', :checked=>'checked'  %>
                                  <%= label :user, :is_mail_list_subscriber, t(:do_subscribe_to_our_mailing_list) %>
                                </p>
                              })

Deface::Override.new(:virtual_path => "spree/layouts/spree_application",
                   :name => "converted_footer_left",
                   :replace => '#location_for_newsletter',
                   :text => %q{
                                <div id=news_letter_signup><h6>Newsletter Signup</h6></div>
                                <div id="news_form">
                                  <%= form_for :user, :remote => true, :id=> 'news_form', :url => :subscriptions do |f| %>
                                            <%= text_field_tag :email, nil, :placeholder => t('enter_your_email'), :class=>'email', :id=>'subscribe_email' %>
                                            <p></p>
                                            <%= submit_tag t('subscribe'), :id => 'op_subscribe' %>
                                  <% end %>
                                </div>
                            })

 #Deface::Override.new(:virtual_path => "spree/layouts/spree_application",
 #                    :name => "more_js",
 #                    :insert_before => 'data-hook[inside_head]',
 #                    :text => %q{
 #                                <%= stylesheet_link_tag 'mail_chimp' %>
 #                               <%= javascript_include_tag 'jquery.simplemodal.1.4.min.js','mailchimp_subscribe' %>
 #                             })

#insert_after :inside_head do
#     "<%= stylesheet_link_tag 'mail_chimp' %>
#	<%= javascript_include_tag 'jquery.simplemodal.1.4.min.js','mailchimp_subscribe' %>"
#end