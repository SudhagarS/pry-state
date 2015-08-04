module Printer
  extend self

  def trunc_and_print var, value, var_color, value_color
    var_name_adjusted = var.to_s.ljust(25)
    print Pry::Helpers::Text.send(var_color, truncate(var_name_adjusted, 25) )
    print_stringified_val_or_nil value, value_color
    print "\n"
  end

  private
  def truncate text, length
    if text.nil? then return end
    l = length - "...".chars.to_a.size
    (text.chars.to_a.size > length ? text.chars.to_a[0...l].join + "..." : text).to_s
  end

  def print_stringified_val_or_nil value, color
    value = stringify_value value
    if value.empty?
      print Pry::Helpers::Text.red 'nil'
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
end
