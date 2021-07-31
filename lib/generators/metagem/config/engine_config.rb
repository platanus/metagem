require_relative 'base_config'

module Metagem
  class EngineConfig < BaseConfig
    def gem_type
      'engine'
    end

    def gem_models_path(resource = nil)
      resource_or_path(gem_app_path("models"), resource)
    end

    def project_gem_initialzer_path
      project_path("config/initializers/#{gem_name}.rb")
    end

    def gem_migrations_path(resource = nil)
      resource_or_path(gem_root_path("/db/migrate"), resource)
    end

    def gem_app_path(resource = nil)
      resource_or_path(gem_root_path("app"), resource)
    end

    def project_last_migration_file_name
      project_last_migration_path.to_s.split("/").last
    end

    def project_last_migration_path
      project_migrations_paths.max
    end

    def project_migrations_paths
      Dir[project_migrate_path("*")]
    end

    def project_migrate_path(resource = nil)
      resource_or_path(project_path("db/migrate"), resource)
    end

    def project_spec_models_path(resource = nil)
      resource_or_path(project_specs_path("models"), resource)
    end

    def project_specs_engine_models_path(resource = nil)
      resource_or_path(project_specs_engines_path("#{gem_name}/models"), resource)
    end

    def project_specs_engines_path(resource = nil)
      resource_or_path(project_specs_path("engines"), resource)
    end

    def project_specs_path(resource = nil)
      resource_or_path(project_path("spec"), resource)
    end

    def project_models_path(resource = nil)
      resource_or_path(project_app_path("models"), resource)
    end

    def project_app_path(resource = nil)
      resource_or_path(project_path("app"), resource)
    end

    def project_path(resource = nil)
      resource_or_path(Rails.root, resource)
    end
  end
end
