require 'spec_helper'
require 'ostruct'

RSpec.describe HookAction do
  context "When a binding.pry called" do
    it "should print the current state" do
      a = 1
      binding.pry
      @b = "world"
      @c = [1, 2, 4, 5]

      # create a sticky locals hash with different @b value to get it in green color
      pry = OpenStruct.new(:config=>OpenStruct.new(:extra_sticky_locals=>{:@b=> 'wrd'}))
      output = capture_stdout do
        HookAction.new(binding, pry).act
      end
      expect(output).to include 'a'
      expect(output).to include a.to_s
      expect(output).to include '@b'
      expect(output).to include "\e[0m\e[0;32m\"#{@b}\"\e[0m\n\e[0;" # for green color
      expect(output).to include '@c'
      expect(output).to include "len:#{@c.count} #{@c}"
    end
  end
end
