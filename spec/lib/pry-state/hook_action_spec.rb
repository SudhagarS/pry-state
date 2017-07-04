require 'spec_helper'
require 'ostruct'

RSpec.describe HookAction do
  # create a sticky locals hash with different @b value to get it in green color
  let(:pry_mock) { OpenStruct.new(config: OpenStruct.new(extra_sticky_locals: { pry_state_prev: { :@b => 'wd' } })) }

  context "when hook is disabled" do
    before { Pry.config.state_hook_enabled = false }

    it "doesn't print anything" do
      output = capture_stdout do
        HookAction.new(anything, anything).act
      end
      expect(output).to be_empty
    end

    context "when force is true" do
      it "prints the current state" do
        user = "Superman"
        output = capture_stdout do
          HookAction.new(binding, pry_mock).act(true)
        end
        line = output.lines.find { |l| l.include? "user" }
        expect(line).not_to be_nil
        expect(line).to include "Superman"
      end
    end
  end

  context "when hook is enabled" do
    before { Pry.config.state_hook_enabled = true }

    # begin/end codes for bright_yellow
    let(:val_chg_begin_code) { "\e[0m\e[1;33m" }
    let(:val_chg_end_code) { "\e[0m\n\e[0;32m@c" }

    it "prints the current state" do
      a = 1
      @b = "world"
      @c = [1, 2, 4, 5]
      output = capture_stdout do
        HookAction.new(binding, pry_mock).act
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
