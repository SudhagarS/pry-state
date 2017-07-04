require "spec_helper"

RSpec.describe "show-state" do
  it "prints local variables" do
    test_string = "secret message"

    output = capture_pry_command("show-state", binding)

    expect(output).to include %(\e[0;36mtest_string          \e[0m\e[0;37m\"secret message\"\e[0m\n)
  end

  it "prints instance variables" do
    @instance_test = "#winning"

    output = capture_pry_command("show-state", binding)

    expect(output).to include %(\e[0;32m@instance_test       \e[0m\e[0;37m\"#winning\"\e[0m\n)
  end

  it "prints objects" do
    test_object = Object.new

    output = capture_pry_command("show-state", binding)

    expect(output).to include %(\e[0;36mtest_object          \e[0m\e[0;37m#{test_object}\e[0m\n)
  end

  it "doesn't print constants" do
    TestMe = Struct.new(:one, :two)

    output = capture_pry_command("show-state", binding)

    expect(output).not_to include "TestMe"
  end

  context "when hook_enabled=false" do
    before { Pry.config.state_hook_enabled = false }

    it "prints state" do
      test_object = Object.new

      output = capture_pry_command("show-state", binding)

      expect(output).to include %(\e[0;36mtest_object          \e[0m\e[0;37m#{test_object}\e[0m\n)
    end
  end
end
