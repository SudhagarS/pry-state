module PryState
  module Printer
    extend self

    WIDTH = ENV['COLUMNS'] ? ENV['COLUMNS'].to_i : 80
    MAX_LEFT_COLUMN_WIDTH = 25
    # Ratios are 1:3 left:right, or 1/4 left
    COLUMN_RATIO = 3 # right column to left ratio
    LEFT_COLUMN_WIDTH = [(WIDTH / (COLUMN_RATIO + 1)).floor, MAX_LEFT_COLUMN_WIDTH].min

    # Defaults to true
    TRUNCATE = ENV['PRY_STATE_TRUNCATE'] != 'false'

    def trunc_and_print var, value, var_color, value_color
      var_name_adjusted = var.to_s.ljust(LEFT_COLUMN_WIDTH)
      # Ensure at least 1 space between left and right columns
      left_column_text = truncate(var_name_adjusted, LEFT_COLUMN_WIDTH - 1) + ' '
      print Pry::Helpers::Text.send(var_color, left_column_text)
      print stringified_val_or_nil(value, value_color, WIDTH - LEFT_COLUMN_WIDTH)
      print "\n"
    end

    private
    def truncate text, length
      if text.nil? then return end
      return text unless ENV['TRUNCATE']
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
end
