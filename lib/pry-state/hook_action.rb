class HookAction
  IGNORABLE_LOCAL_VARS = [:__, :_, :_ex_, :_pry_, :_out_, :_in_, :_dir_, :_file_, :prev_binding]
  IGNORABLE_INSTANCE_VARS = [:@_request, :@_response, :@_routes, :@_prev_instance_state, :@_prev_local_state]

  def initialize binding
    @binding = binding
    @instance_variables = @binding.eval('instance_variables')
    @local_variables = @binding.eval('local_variables')
  end

  def act
    (instance_variables - IGNORABLE_INSTANCE_VARS).each do |var|
      eval_and_print var, 'green'
    end

    (local_variables - IGNORABLE_LOCAL_VARS).each do |var|
      eval_and_print var, 'cyan'
    end
  end

  private
  attr_reader :binding, :instance_variables, :local_variables

  def eval_and_print var, color
    print Pry::Helpers::Text.send(color, var.to_s.ljust(25).truncate(25))
    value = binding.eval(var.to_s)
    if instance_variables.include?(:@_prev_binding) && value != prev_value(var)
      print 'sd'
      print_stringified_val_or_nil value
    else
      print_stringified_val_or_nil value
    end
  end

  def print_stringified_val_or_nil value
    value = stringify_value value
    if value.empty?
      print Pry::Helpers::Text.red 'nil'
    else
      print value.truncate(60)
    end
    print "\n"
  end

  def stringify_value value
    if value.class == String
      "\"#{value}\""
    else
      value.to_s
    end
  end

  # def prev_value var
  #   prev_binding = binding.eval('@_prev_binding')
  #   puts binding
  #   puts prev_binding
  #   value = prev_binding.eval var.to_s
  #   print "prev value of #{var} is #{value.to_s.truncate(20)}"
  #   value
  # end

end
