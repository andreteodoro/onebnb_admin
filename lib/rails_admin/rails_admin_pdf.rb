module RailsAdminPdf
end

require 'rails_admin/config/actions'

module RailsAdmin
  module Config
    module Actions
      class Pdf < Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :member do
          true
        end

        register_instance_option :controller do
          Proc.new do
            report = "#{@object.class.to_s.demodulize}Report".constantize.new
            send_data report.to_pdf(@object), :filename => "#{@object.class.to_s.demodulize}_#{@object.id}.pdf", :type => "application/pdf"
          end
        end

        register_instance_option :link_icon do
          'icon-folder-open'
        end

        # display only for models with Report class
        register_instance_option :visible? do
          # test if class exists
          # (dirty way because of autoload)
          begin
            "#{bindings[:object].class}Report".constantize
            class_exists = true
          rescue
            class_exists = false
          end

          class_exists && authorized?
        end

        # disable turbolinks. send_data does not work with it
        register_instance_option :pjax? do
          false
        end
      end
    end
  end
end
