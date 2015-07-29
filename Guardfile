guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{lib/pry-state/(.+).rb})  { |m| "spec/lib/pry-state/#{m[1]}_spec.rb" }
  watch(%r{spec/lib/pry-state/(.+)_spec.rb})  { |m| "spec/lib/pry-state/#{m[1]}_spec.rb" }
end
