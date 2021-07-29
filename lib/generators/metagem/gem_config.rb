module Metagem
  class GemConfig
    SEPARATOR_COUNT = 50

    attr_accessor :summary, :engine
    attr_writer :human_gem_name, :description
    attr_reader :gem_name

    def initialize
      self.engine = :normal
    end

    def gem_name=(name)
      @gem_name = name.to_s.dasherize
    end

    def human_gem_name
      return gem_name.titleize if @human_gem_name.blank?

      @human_gem_name
    end

    def gem_class
      gem_name.camelize
    end

    def description
      return summary if @description.blank?

      @description
    end

    def gem_directory
      gem_type.pluralize
    end

    def gem_type
      engine? ? 'engine' : 'gem'
    end

    def gem_path
      "#{gem_directory}/#{gem_name}"
    end

    def gem_lib_path
      "#{gem_path}/lib/#{gem_name}"
    end

    def engine?
      !!engine
    end

    def to_s
      <<~HERE

        #{'=' * SEPARATOR_COUNT}
        Configuración
        #{'-' * SEPARATOR_COUNT}
        #{gem_type.capitalize} name: #{gem_name}
        Human gem: #{human_gem_name}
        Summary: #{summary}
        Description: #{description}
        #{'=' * SEPARATOR_COUNT}

      HERE
    end
  end
end
