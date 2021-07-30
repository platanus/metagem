require_relative '../config/engine_config'

class Metagem::NewEngineGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def load_config
    config.gem_name = file_name
    config.human_gem_name = ask("Enter engine 'human name':", default: config.human_gem_name)
    config.summary = ask("Enter the summary of what your plugin does (one sentence):")
    config.description = ask("Enter engine description (try a little harder here):")
  end

  def show_info
    puts config.to_s
  end

  def generate_engine
    rails_command("plugin new #{config.path} --mountable --skip-git")
  end

  def clean_engine
    remove_dir("#{config.path}/test")
    remove_dir("#{config.lib_path}/tasks")
    remove_file("#{config.path}/Rakefile")
    remove_file("#{config.path}/MIT-LICENSE")
    remove_dir("#{config.path}/bin")
  end

  def replace_readme
    template("README.md.erb", config.readme_path, force: true)
  end

  def replace_gemspec
    template("gemspec.erb", config.gemspec_path, force: true)
  end

  def replace_main_file
    template("main.rb.erb", config.main_file_path, force: true)
  end

  def add_active_admin_config_file
    return unless Metagem.use_active_admin

    template("activeadmin_config.rb.erb", config.activeadmin_config_path)
  end

  def add_errors_file
    template("errors.rb.erb", config.errors_path)
  end

  def relace_gemfile
    template("engine_gemfile", config.gemfile_path, force: true)
  end

  def replace_engine_file
    template("engine.rb.erb", config.engine_file_path, force: true)
  end

  def create_initializer
    template("initializer.rb.erb", config.initializer_path)
  end

  private

  def config
    @config ||= Metagem::EngineConfig.new
  end
end
