RailsAdmin.config do |config|
  config.main_app_name = Proc.new { |controller| [ "OneBnb", "Admin - #{controller.params[:action].try(:titleize)}" ] }

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  config.authorize_with do
    if current_user.kind != "admin"
      reset_session
      redirect_to '/users/sign_in'
    end
  end

  require Rails.root.join('lib', 'rails_admin', 'rails_admin_pdf.rb')
  RailsAdmin::Config::Actions.register(RailsAdmin::Config::Actions::Pdf)

  config.excluded_models << "Photo"

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    pdf
  end
end
