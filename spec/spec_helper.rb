require "pry-state"
require "rspec"
require 'stringio'


RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end
  config.mock_with :rspec
  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!

  if config.files_to_run.one?
    config.default_formatter = 'doc'
  end

  config.profile_examples = 10
  config.order = :random

  config.before do
    # ensure that Pry doesn't capture the state from previous tests
    Pry.config.extra_sticky_locals = {}
  end

  Kernel.srand config.seed
end

def capture_stdout(&blk)
  old_out = $stdout
  $stdout = Pry.output = fake = StringIO.new
  blk.call
  fake.string
ensure
  $stdout = Pry.output = old_out
end

def capture_stderr(&blk)
  old = $stderr
  $stderr = fake = StringIO.new
  blk.call
  fake.string
ensure
  $stderr = old
end

def capture_pry_command(command, cmd_binding=binding)
  old_in = Pry.input
  Pry.input = StringIO.new("#{command}\nexit-all")
  capture_stdout do
    Pry.start_without_pry_nav(cmd_binding, hooks: Pry::Hooks.new)
  end
ensure
  Pry.input = old_in
end
