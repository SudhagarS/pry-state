class PryState::ShowState < Pry::ClassCommand
  match "show-state"
  group "pry-state"
  description "Show the current binding state."

  def options(opt)
    opt.banner unindent <<-USAGE
      Usage: show-state

      show-state will show the current binding state.

      Use `toggle-state` to turn on automatic state display.
    USAGE
  end

  def process
    HookAction.new(target, _pry_).act(true)
  end
end

PryState::Commands.add_command PryState::ShowState
