module GeneratorHelpers
  extend ActiveSupport::Concern

  included do
    destination(File.expand_path("../../tmp", __dir__))

    before do
      allow(Rails).to receive(:root).and_return(File.expand_path("../../tmp", __dir__))
    end
  end

  def destroy_tmp_dir
    FileUtils.rm_rf(File.expand_path("../../tmp", __dir__).to_s)
  end

  def perform
    run_generator(generator_params)
  end
end

RSpec.configure do |config|
  config.include GeneratorHelpers, type: :generator
end
