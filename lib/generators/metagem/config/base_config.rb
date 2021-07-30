module Metagem
  class BaseConfig
    SEPARATOR_COUNT = 50

    attr_accessor :summary, :engine
    attr_writer :human_gem_name, :description
    attr_reader :gem_name

    def gem_type
      raise "gem_type not implemented"
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

    def gem_type_path
      gem_type.pluralize
    end

    def path
      "#{gem_type_path}/#{gem_name}"
    end

    def lib_gem_path
      "#{lib_path}/#{gem_name}"
    end

    def lib_path
      "#{path}/lib"
    end

    def gemfile_path
      "#{path}/Gemfile"
    end

    def errors_path
      "#{lib_gem_path}/errors.rb"
    end

    def main_file_path
      "#{path}/lib/#{gem_name}.rb"
    end

    def gemspec_path
      "#{path}/#{gem_name}.gemspec"
    end

    def readme_path
      "#{path}/README.md"
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
