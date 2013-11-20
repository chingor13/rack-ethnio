class Rack::EthnioRails < ::Rails::Railtie

  module Helper
    def show_ethnio!(ethnio_id)
      env['rack.ethnio'] ||= []
      env['rack.ethnio'] << ethnio_id
    end
  end

  initializer "rack.ethnio-rails" do |app|
    app.config.middleware.use Rack::Ethnio

    ActiveSupport.on_load(:action_controller) do
      include Helper
    end
  end
end