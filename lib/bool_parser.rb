# frozen_string_literal: true

class BoolParser
  # @param [String] env_value string from env
  # @param [Boolean] default value if the env value is nil or not valid
  # @return [Boolean]
  def self.call(env_value, default)
    return true if env_value == '1'
    return true if env_value == 'true'
    default
  end
end
