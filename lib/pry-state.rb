require "pry"
require "pry-state/version"
require 'pry-state/hook_action'


Pry.hooks.add_hook(:before_session, "pry_state_hook") do |output, binding, pry|
  HookAction.new(binding, pry).act
end
