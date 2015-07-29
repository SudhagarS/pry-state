class HookAction
  IGNORABLE_LOCAL_VARS = [:__, :_, :_ex_, :_pry_, :_out_, :_in_, :_dir_, :_file_]
  IGNORABLE_INSTANCE_VARS = [:@_request, :@_response, :@_routes]

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
    var_name_adjusted = var.to_s.ljust(25)
    print Pry::Helpers::Text.send(color, truncate(var_name_adjusted, 25) )
    value = binding.eval(var.to_s)
    print_stringified_val_or_nil value
  end

  def print_stringified_val_or_nil value
    value = stringify_value value
    if value.empty?
      print Pry::Helpers::Text.red 'nil'
    else
      print truncate(value, 60)
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

  def truncate text, length
    if text.nil? then return end
    l = length - "...".chars.to_a.size
    (text.chars.to_a.size > length ? text.chars.to_a[0...l].join + "..." : text).to_s
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
