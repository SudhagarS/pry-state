require 'spec_helper'

RSpec.describe HookAction do
  context "When a binding.pry called" do
    it "should print the current state" do
      a = 1
      @b = "world"
      @c = [1, 2, 4, 5]
      output = capture_stdout do
        HookAction.new(binding).act
      end
      expect(output).to include 'a'
      expect(output).to include 1.to_s
      expect(output).to include '@b'
      expect(output).to include '"world"'
    end
  end
end
