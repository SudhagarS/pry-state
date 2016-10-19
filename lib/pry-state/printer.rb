module Printer
  extend self

  def trunc_and_print var, value, var_color, value_color
    width = ENV['COLUMNS'] ? ENV['COLUMNS'].to_i : 80
    # Ratios are 1:3 left:right
    left_column_width = width / 4
    left_column_width = left_column_width < 25 ? 25 : left_column_width
    var_name_adjusted = var.to_s.ljust(left_column_width)
    # Ensure at least 1 space between left and right columns
    left_column_text = truncate(var_name_adjusted, left_column_width - 1) + ' '
    print Pry::Helpers::Text.send(var_color, left_column_text)
    print stringified_val_or_nil(value, value_color, width - left_column_width)
    print "\n"
  end

  private
  def truncate text, length
    if text.nil? then return end
    l = length - "...".length
    (text.chars.to_a.size > length ? text.chars.to_a[0...l].join + "..." : text).to_s
  end

  def stringified_val_or_nil value, color, length
    value = stringify_value value
    if value.empty?
      Pry::Helpers::Text.red 'nil'
    else
      text = truncate(value, length)
      Pry::Helpers::Text.send(color, text)
    end
  end

  def stringify_value value
    if value.class == String
      "\"#{value}\""
    elsif value.class == Array
      "len:#{value.count} #{value.inspect}"
    else
      value.inspect
    end
  end
end
