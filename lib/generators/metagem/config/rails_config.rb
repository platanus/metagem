module Metagem
  class RailsConfig
    def last_migration_file_name
      last_migration_path.to_s.split("/").last
    end

    def engines_spec_path
      "#{spec_path}/engines"
    end

    def models_path
      "#{app_path}/models"
    end

    def spec_path
      "#{project_path}/spec"
    end

    def app_path
      "#{project_path}/app"
    end

    def last_migration_path
      migrations_paths.max
    end

    def migrations_paths
      Dir["#{project_path}/db/migrate/*"]
    end

    def project_path
      Rails.root
    end
  end
end
