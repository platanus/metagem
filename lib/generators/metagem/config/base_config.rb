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
      @gem_name = name.to_s.underscore
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

    def gem_lib_gem_path(resource = nil)
      resource_or_path("#{gem_lib_path}/#{gem_name}", resource)
    end

    def gem_lib_path(resource = nil)
      resource_or_path(gem_root_path("lib"), resource)
    end

    def gem_main_file_path
      gem_lib_path("#{gem_name}.rb")
    end

    def gemspec_path
      gem_root_path("#{gem_name}.gemspec")
    end

    def gem_root_path(resource = nil)
      resource_or_path("#{Rails.root}/#{gem_type_path}/#{gem_name}", resource)
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

    private

    def resource_or_path(path, resource)
      return path unless resource

      "#{path}/#{resource}"
    end

    def gem_type_path
      gem_type.pluralize
    end
  end
end
