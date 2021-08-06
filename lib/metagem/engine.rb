module Metagem
  class Engine < ::Rails::Engine
    isolate_namespace Metagem

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end

    initializer "initialize" do
      # Require here all your engine's classes.
    end

    generators do |app|
      Rails::Generators.configure!(app.config.generators)
      Rails::Generators.hidden_namespaces.uniq!
      require 'generators/rails/model_override'
    end
  end
end
