class PryState::ToggleState < Pry::ClassCommand
  match "toggle-state"
  group "pry-state"
  description "Toggle automatic pry-State display."

  def options(opt)
    opt.banner unindent <<-USAGE
      Usage: toggle-state

      toggle-state will toggle automatic state display. Off by default.
      Set `Pry.config.pry_state.hook_enabled = true` in your config file to
      always turn it on.

      Use `show-state` to just show the current state.
    USAGE
  end

  def process
    if Pry.config.pry_state.hook_enabled ^= true
      output.puts "pry-state enabled."
      HookAction.new(target, _pry_).act
    else
      output.puts "pry-state disabled."
    end
  end
end

PryState::Commands.add_command PryState::ToggleState
