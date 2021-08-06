require 'rails_helper'

require_relative '../../../lib/generators/metagem/new_engine/new_engine_generator.rb'

describe Metagem::NewEngineGenerator, type: :generator do
  let(:use_active_admin) { true }
  let(:engine_name) { "feedback" }
  let(:readme_file) { file("engines/feedback/README.md") }
  let(:gemspec_file) { file("engines/feedback/feedback.gemspec") }
  let(:main_file) { file("engines/feedback/lib/feedback.rb") }
  let(:errors_file) { file("engines/feedback/lib/feedback/errors.rb") }
  let(:extensions_file) { file("engines/feedback/lib/feedback/extensions.rb") }
  let(:extensions_dir) { file("engines/feedback/app/extensions/feedback/.gitkeep") }
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

  before do
    allow(Metagem).to receive(:use_active_admin).and_return(use_active_admin)
    perform
  end

  after { destroy_tmp_dir }

  it "removes files and directories" do
    expect(dummy_app).not_to exist
    expect(tasks_dir).not_to exist
    expect(rakefile).not_to exist
    expect(license).not_to exist
    expect(bin_dir).not_to exist
  end

  it "generates valid content" do
    expect(readme_file).to contain("# Feedback")
    expect(gemspec_file).to contain("spec.name = \"feedback\"")
    expect(main_file).to contain("require \"feedback/engine\"")
    expect(errors_file).to contain("module Feedback\n  class Error < StandardError\n  end\nend\n")
    expect(extensions_file).to contain("include Feedback::MyModelExt")
    expect(extensions_dir).to exist
    expect(engine_gemfile).to contain("https://rubygems.org")
    expect(engine_file).to contain("isolate_namespace Feedback")
    expect(engine_file).to contain("activeadmin_config")
    expect(engine_file).to contain("errors")
    expect(engine_file).to contain("extensions")
    expect(initializer).to contain("Feedback.configure do |config|\nend\n")
  end

  context "with active admin disabled" do
    let(:use_active_admin) { false }

    it { expect(engine_file).not_to contain("activeadmin_config") }
  end
end
