class PryState::ToggleState < Pry::ClassCommand
  match "toggle-state"
  group "pry-state"
  description "Toggle automatic pry-State display."

  def options(opt)
    opt.banner unindent <<-USAGE
      Usage: toggle-state

      toggle-state will toggle automatic state display. Off by default.
      Set `Pry.config.state_hook_enabled = true` in your .pryrc file to
      permanently enable it.

      Use `show-state` to show the current state.
    USAGE
  end

  def process
    if Pry.config.state_hook_enabled ^= true
      output.puts "pry-state enabled."
      HookAction.new(target, Pry).act
    else
      output.puts "pry-state disabled."
    end
  end
end

PryState::Commands.add_command PryState::ToggleState
