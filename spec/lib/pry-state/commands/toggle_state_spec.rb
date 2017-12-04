require "spec_helper"

RSpec.describe "toggle-state" do
  context "when the hook is enabled" do
    before { allow(Pry.config).to receive(:state_hook_enabled).and_return(true) }

    it "sets the hook config to be disabled" do
      expect(Pry.config).to receive(:state_hook_enabled=).with(false)
      output = capture_pry_command("toggle-state", binding)
      expect(output).to include "pry-state disabled."
    end
  end

  context "when the hook is disabled" do
    before { allow(Pry.config).to receive(:state_hook_enabled).and_return(false) }

    it "sets the hook config to be enabled" do
      # If the developer has `Pry.config.state_hook_enabled = true` in their
      # .pryrc, this expectation will get called twice; take that into account
      expect(Pry.config).to receive(:state_hook_enabled=).with(true).at_least(:once)
      output = capture_pry_command("toggle-state", binding)
      expect(output).to include "pry-state enabled."
    end
  end
end
