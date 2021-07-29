require_relative '../gem_config'

class Metagem::NewEngineGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('templates', __dir__)

  def load_config
    config.engine = true
    config.gem_name = file_name
    config.human_gem_name = ask("Enter engine 'human name':", default: config.human_gem_name)
    config.summary = ask("Enter the summary of what your plugin does (one sentence):")
    config.description = ask("Enter engine description (try a little harder here):")
  end

  def show_info
    puts config.to_s
  end

  def generate_engine
    rails_command("plugin new #{config.gem_path} --mountable --skip-git")
  end

  def clean_engine
    remove_dir("#{config.gem_path}/test")
    remove_dir("#{config.gem_path}/lib/tasks")
    remove_file("#{config.gem_path}/Rakefile")
    remove_file("#{config.gem_path}/MIT-LICENSE")
    remove_file("#{config.gem_path}/bin/rails")
  end

  def replace_readme
    template(
      "README.md.erb",
      "#{config.gem_path}/README.md",
      force: true
    )
  end

  def replace_gemspec
    template(
      "gemspec.erb",
      "#{config.gem_path}/#{config.gem_name}.gemspec",
      force: true
    )
  end

  def replace_main_file
    template(
      "main.rb.erb",
      "#{config.gem_path}/lib/#{config.gem_name}.rb",
      force: true
    )
  end

  def add_active_admin_config_file
    return unless Metagem.use_active_admin

    template(
      "activeadmin_config.rb.erb",
      "#{config.gem_lib_path}/activeadmin_config.rb"
    )
  end

  def add_errors_file
    template(
      "errors.rb.erb",
      "#{config.gem_lib_path}/errors.rb"
    )
  end

  def relace_gemfile
    template(
      "engine_gemfile",
      "#{config.gem_path}/Gemfile",
      force: true
    )
  end

  def replace_engine_file
    engine_file_path = "#{config.gem_lib_path}/engine.rb"
    template("engine.rb.erb", engine_file_path, force: true)
  end

  def create_initializer
    template(
      "initializer.rb.erb",
      "config/initializers/#{config.gem_name}.rb"
    )
  end

  private

  def config
    @config ||= Metagem::GemConfig.new
  end
end
