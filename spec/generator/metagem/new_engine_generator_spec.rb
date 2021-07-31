require 'rails_helper'

require_relative '../../../lib/generators/metagem/new_engine/new_engine_generator.rb'

describe Metagem::NewEngineGenerator, type: :generator do
  let(:engine_name) { "feedback" }
  let(:readme_file) { file("engines/feedback/README.md") }
  let(:gemspec_file) { file("engines/feedback/feedback.gemspec") }
  let(:main_file) { file("engines/feedback/lib/feedback.rb") }
  let(:errors_file) { file("engines/feedback/lib/feedback/errors.rb") }
  let(:engine_gemfile) { file("engines/feedback/Gemfile") }
  let(:engine_file) { file("engines/feedback/lib/feedback/engine.rb") }
  let(:initializer) { file("config/initializers/feedback.rb") }
  let(:dummy_app) { file("engines/feedback/test") }
  let(:tasks_dir) { file("engines/feedback/lib/tasks") }
  let(:rakefile) { file("engines/feedback/Rakefile") }
  let(:license) { file("engines/feedback/MIT-LICENSE") }
  let(:bin_dir) { file("engines/feedback/bin") }

  let(:generator_params) do
    [
      engine_name
    ]
  end

  before { perform }
  after { destroy_tmp_dir }

  it "removes files and directories" do
    expect(dummy_app).not_to exist
    expect(tasks_dir).not_to exist
    expect(rakefile).not_to exist
    expect(license).not_to exist
    expect(bin_dir).not_to exist
  end

  fit "generates valid content" do
    expect(readme_file).to contain("# Feedback")
    expect(gemspec_file).to contain("spec.name = \"feedback\"")
    expect(main_file).to contain("require \"feedback/engine\"")
    expect(errors_file).to contain("module Feedback\n  class Error < StandardError\n  end\nend\n")
    expect(engine_gemfile).to contain("https://rubygems.org")
    expect(engine_file).to contain("isolate_namespace Feedback")
    expect(initializer).to contain("Feedback.configure do |config|\nend\n")
  end
end
