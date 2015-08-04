require 'spec_helper'
require 'ostruct'

RSpec.describe HookAction do
  context "When a binding.pry called" do
    # begin/end codes for bright_yellow
    let(:val_chg_begin_code) {"\e[0m\e[1;33m"}
    let(:val_chg_end_code) { "\e[0m\n\e[0;32m@c" }
    it "should print the current state" do
      a = 1
      @b = "world"
      @c = [1, 2, 4, 5]
      a = 2
      # create a sticky locals hash with different @b value to get it in green color
      pry = OpenStruct.new(:config=>OpenStruct.new(:extra_sticky_locals=>{:pry_state_prev=>{:@b=>'wd'}}))
      output = capture_stdout do
        HookAction.new(binding, pry).act
      end

      expect(output).to include 'a'
      expect(output).to include a.to_s
      expect(output).to include '@b'
      expect(output).to include val_chg_begin_code + "\"#{@b}\"" + val_chg_end_code
      expect(output).to include '@c'
      expect(output).to include "len:#{@c.count} #{@c}"
    end
  end
end
