class HookAction
  IGNORABLE_LOCAL_VARS = [:__, :_, :_ex_, :_pry_, :_out_, :_in_, :_dir_, :_file_]

  CONTROLLER_INSTANCE_VARIABLES = [:@_request, :@_response, :@_routes]
  RSPEC_INSTANCE_VARIABLES = [:@__inspect_output, :@__memoized]
  IGNORABLE_INSTANCE_VARS = CONTROLLER_INSTANCE_VARIABLES + RSPEC_INSTANCE_VARIABLES

  def initialize binding, pry
    @binding, @pry = binding, pry
    @instance_variables = @binding.eval('instance_variables')
    @local_variables = @binding.eval('local_variables')
  end

  def act
    (instance_variables - IGNORABLE_INSTANCE_VARS).each do |var|
      eval_and_print var, var_color: 'green'
    end

    (local_variables - IGNORABLE_LOCAL_VARS).each do |var|
      eval_and_print var, var_color: 'cyan'
    end
  end

  private
  attr_reader :binding, :pry, :instance_variables, :local_variables

  def eval_and_print var, var_color: 'green', value_color: 'white'
    value = binding.eval(var.to_s)
    if value_changed? var, value
      var_color = "bright_#{var_color}"; value_color = 'bright_magenta'
    end

    var_name_adjusted = var.to_s.ljust(25)
    print Pry::Helpers::Text.send(var_color, truncate(var_name_adjusted, 25) )
    print_stringified_val_or_nil value, value_color
    print "\n"

    stick_value! var, value # to refer the value in next
  end

  def print_stringified_val_or_nil value, color
    value = stringify_value value
    if value.empty?
      print Pry::Helpers::Text.bright_red 'nil'
    else
      print Pry::Helpers::Text.send(color, truncate(value, 60) )
    end
  end

  def stringify_value value
    if value.class == String
      "\"#{value}\""
    elsif value.class == Array
      "len:#{value.count} #{value}"
    else
      value.to_s
    end
  end

  def truncate text, length
    if text.nil? then return end
    l = length - "...".chars.to_a.size
    (text.chars.to_a.size > length ? text.chars.to_a[0...l].join + "..." : text).to_s
  end

  def value_changed? var, value
    pry.config.extra_sticky_locals[var] and pry.config.extra_sticky_locals[var] != value
  end

  def stick_value! var, value
    pry.config.extra_sticky_locals[var] = value
  end

end
