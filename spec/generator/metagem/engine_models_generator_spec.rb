require 'rails_helper'

require_relative '../../../lib/generators/rails/model_override.rb'
require_relative '../../../lib/generators/metagem/engine_model/engine_model_generator.rb'

describe Rails::Generators::ModelGenerator, type: :generator do
  let(:model_name) { "feedback/session" }
  let(:spec_file) { file("spec/engines/feedback/models/feedback/session_spec.rb") }
  let(:model_file) { file("engines/feedback/app/models/feedback/session.rb") }
  let(:model_namespcae) { file("app/models/feedback.rb") }
  let(:migration) { Dir["#{Rails.root}/engines/feedback/db/migrate/*"].max }
  let(:generator_params) do
    [
      model_name,
      "--engine-model",
      "--test-framework=rspec"
    ]
  end

  before { perform }
  after { destroy_tmp_dir }

  it { expect(spec_file).to contain("RSpec.describe Feedback::Session, type: :model") }
  it { expect(model_file).to contain("Feedback::Session < Feedback::ApplicationRecord") }
  it { expect(migration).to contain("create_table :feedback_sessions") }
  it { expect(model_namespcae).not_to exist }
end
