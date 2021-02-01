# Plissken

[![Gem Version](https://badge.fury.io/rb/plissken.svg)](https://badge.fury.io/rb/plissken)
![CI](https://github.com/technicalpanda/plissken/workflows/.github/workflows/CI/badge.svg)

Have you ever needed to automatically convert JSON-style `camelBack` or `CamelCase` hash keys into more Rubyish `snake_case`?

Plissken to the rescue!

This gem recursively converts all camelBack or CamelCase keys in either a Hash structure, or an Array of Hashes, to snake_case.

## Installation

Add this to your Gemfile:

```ruby
gem "plissken"
```

Or install it yourself as:

```bash
gem install plissken
```

## Usage

On hashes:

```ruby
my_hash = { "firstKey" => 1, "fooBars" => [{ "bazBaz" => "value" }, { "blahBlah" => "value" }] }
snaked_hash = my_hash.to_snake_keys
# => { "first_key" => 1, "foo_bars" => [{ "baz_baz" => "value" }, { "blah_blah" => "value" }] }
```

On arrays:

```ruby
my_array_of_hashes = [{ "firstKey" => 1, "fooBars" => [{ "bazBaz" => "value" }, { "blahBlah" => "value" }] }]
snaked_hash = my_array_of_hashes.to_snake_keys
# => [{"first_key" => 1, "foo_bars" => [{ "baz_baz" => "value" }, { "blah_blah" => "value" }] }]
```

Plissken works on either string keys or symbolized keys. It has no dependencies, as it has its own `underscore` method lifted out of ActiveSupport.

## Limitations

* Your keys must be camelBack or CamelCase. The key "Foo Bar" will output as "foo bar".
* Unlike the original Snake Plissken in the seminal film [Escape from New York](http://en.wikipedia.org/wiki/Escape_from_New_York), the plissken gem is non-destructive. There is no `Hash#to_snake_keys!` form.

# Going the other way

If you've already got `snake_case` and need to `CamelCase` it, you are encouraged to try
the [Awrence](http://github.com/futurechimp/awrence) gem.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/technicalpanda/plissken. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting with this project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/technicalpanda/plissken/blob/main/CODE_OF_CONDUCT.md).
