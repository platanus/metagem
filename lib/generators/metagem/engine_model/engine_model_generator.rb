require_relative '../config/engine_config'

class Metagem::EngineModelGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def move_migration
    return if config.project_last_migration_file_name.blank?

    copy_file(
      config.project_last_migration_path,
      config.gem_migrations_path(config.project_last_migration_file_name)
    )
    remove_file(config.project_last_migration_path)
  end

  def move_model
    model_path = config.project_models_path("#{name}.rb")
    new_model_path = config.gem_models_path("#{name}.rb")
    copy_file(model_path, new_model_path, force: true)
    remove_dir(config.project_models_path(config.gem_name), force: true)

    gsub_file(new_model_path, "ApplicationRecord") do |_match|
      "#{config.gem_class}::ApplicationRecord"
    end
  rescue Thor::Error => e
    puts e.message
  end

  def remove_model_namespace
    remove_file(config.project_models_path("#{config.gem_name}.rb"))
  end

  def move_spec
    spec_path = config.project_spec_models_path("#{name}_spec.rb")
    new_spec_path = config.project_specs_engine_models_path("#{name}_spec.rb")
    copy_file(spec_path, new_spec_path, force: true)
    remove_dir(config.project_spec_models_path(config.gem_name), force: true)
  rescue Thor::Error => e
    puts e.message
  end

  private

  def config
    @config ||= begin
      engine_config = Metagem::EngineConfig.new
      engine_config.gem_name = name_parts.first
      engine_config
    end
  end

  def model_name
    @model_name ||= name_parts.last
  end

  def name_parts
    @name_parts ||= name.split('/')
  end
end
