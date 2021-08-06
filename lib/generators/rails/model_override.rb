require 'rails/generators'
require 'rails/generators/rails/model/model_generator'

module Metagem
  module ModelGenetarotExtension
    extend ActiveSupport::Concern

    included do
      hook_for :engine_model, type: :string, in: :metagem
    end
  end
end

Rails::Generators::ModelGenerator.include(Metagem::ModelGenetarotExtension)
