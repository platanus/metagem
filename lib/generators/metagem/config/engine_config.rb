require_relative 'base_config'

module Metagem
  class EngineConfig < BaseConfig
    def gem_type
      'engine'
    end

    def models_path
      "#{app_path}/models"
    end

    def app_path
      "#{path}/app"
    end

    def models_spec_path
      "#{spec_path}/models"
    end

    def spec_path
      "#{path}/spec"
    end

    def engine_file_path
      "#{lib_gem_path}/engine.rb"
    end

    def initializer_path
      "config/initializers/#{gem_name}.rb"
    end

    def activeadmin_config_path
      "#{lib_gem_path}/activeadmin_config.rb"
    end

    def migrate_path
      "#{path}/db/migrate"
    end
  end
end
