require_relative 'base_config'

module Metagem
  class EngineConfig < BaseConfig
    def gem_type
      'engine'
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
  end
end
