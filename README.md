# Pry-State

Why?
When you are debugging, you care about the state of your program. You want to inspect which value is nil or which array is still empty or something similar. The default pry session doesn't give you all these info. You have to evaluate the variables in the prompt to really see what's going on. It is this problem that this extension of pry is trying to solve.

Pry state is an extension of pry. With pry state you can see the values of the instance and local variables in a pry session.

![SCREENSHOT] (https://cloud.githubusercontent.com/assets/1620848/9140567/d57047a4-3d4f-11e5-901e-d508c01c8d52.png)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pry-state'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pry-state

## Usage

There is no need to edit any configuration. After you have added the dependency in Gemfile, pry-state will add a hook to pry to listen to before_session events.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Roadmap

1. Indicate the CHANGE in value between pry sessions by different color. [DONE]
2. Associate the variables with numbers, and support command to evaluate the variable through these numbers. eg. command 's1' will show the value of first variable and so on.

## Contributing

1. Fork it ( https://github.com/[my-github-username]/pry-state/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
