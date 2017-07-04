require "spec_helper"

RSpec.describe "toggle-state" do
  context "when the hook is enabled" do
    before { Pry.config.state_hook_enabled = true }

    it "sets the hook config to be disabled" do
      output = capture_pry_command("toggle-state", binding)
      expect(output).to include "pry-state disabled."
      expect(Pry.config.state_hook_enabled).to eq false
    end
  end

  context "when the hook is disabled" do
    before { Pry.config.state_hook_enabled = false }

    it "sets the hook config to be enabled" do
      output = capture_pry_command("toggle-state", binding)
      expect(output).to include "pry-state enabled."
      expect(Pry.config.state_hook_enabled).to eq true
    end
  end
end
