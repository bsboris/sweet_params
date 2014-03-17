module SweetParams
  module Extensions
    def has?(path, options = nil)
      options ? !!validate(path, options) : get_param_by_path(path).present?
    end

    def validate(path, options)
      param = get_param_by_path(path)
      param.present? && allowed?(param, options) ? param : nil
    end

    def validate_to_sym(path, options)
      validate(path, options).try(:to_sym)
    end

    private

    def get_param_by_path(*path)
      path.flatten.reduce(self) { |hash, key| hash && hash[key] }
    end

    def allowed?(param, options)
      if (whitelist = *options[:in]).any?
        whitelist.flatten.map(&:to_s).include?(param)
      else
        false
      end
    end
  end
end

ActionController::Parameters.send :include, SweetParams::Extensions
