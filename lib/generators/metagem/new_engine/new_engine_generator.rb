require_relative '../config/engine_config'

class Metagem::NewEngineGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def load_config
    config.gem_name = file_name

    if !Rails.env.test?
      config.human_gem_name = ask("Enter engine 'human name':", default: config.human_gem_name)
      config.summary = ask("Enter the summary of what your plugin does (one sentence):")
      config.description = ask("Enter engine description (try a little harder here):")
    end
  end

  def show_info
    puts config.to_s
  end

  def generate_engine
    rails_command("plugin new #{config.gem_root_path} --mountable --skip-git")
  end

  def clean_engine
    remove_dir(config.gem_root_path("test"))
    remove_dir(config.gem_lib_path("tasks"))
    remove_file(config.gem_root_path("Rakefile"))
    remove_file(config.gem_root_path("MIT-LICENSE"))
    remove_dir(config.gem_root_path("bin"))
  end

  def replace_readme
    template("README.md.erb", config.gem_root_path("README.md"), force: true)
  end

  def replace_gemspec
    template("gemspec.erb", config.gemspec_path, force: true)
  end

  def replace_main_file
    template("main.rb.erb", config.gem_main_file_path, force: true)
  end

  def add_active_admin_config_file
    return unless Metagem.use_active_admin

    template("activeadmin_config.rb.erb", config.gem_lib_gem_path("activeadmin_config.rb"))
  end

  def add_errors_file
    template("errors.rb.erb", config.gem_lib_gem_path("errors.rb"))
  end

  def relace_gemfile
    template("engine_gemfile", config.gem_root_path("Gemfile"), force: true)
  end

  def replace_engine_file
    template("engine.rb.erb", config.gem_lib_gem_path("engine.rb"), force: true)
  end

  def create_initializer
    template("initializer.rb.erb", config.project_gem_initialzer_path)
  end

  private

  def config
    @config ||= Metagem::EngineConfig.new
  end
end
