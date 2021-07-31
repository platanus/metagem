# Metagem

[![Gem Version](https://badge.fury.io/rb/metagem.svg)](https://badge.fury.io/rb/metagem)
[![CircleCI](https://circleci.com/gh/platanus/metagem.svg?style=shield)](https://app.circleci.com/pipelines/github/platanus/metagem)

Metagem generates the structure and configuration necessary to have plugins (gems and engines) inside your Rails project.

## Installation

Add to your Gemfile:

```ruby
gem "metagem"
```

```bash
bundle install
```

Then, run the installer:

```bash
rails generate metagem:install
```

## Usage

### Engines

#### Engine creation

In order to create a new engine you must run, in the root path of your project, the following generator:

```bash
bundle exec rails g metagem:new_engine engine_name
```

For example:

```bash
bundle exec rails g metagem:new_engine recruiting
```

#### Engine model creation

In order to create a new model in the engine you must run, in the root path of your project, the following generator:

```bash
bundle exec rails g model engine_name/model_name --engine-model
```

For example:

```bash
bundle exec rails g model recruiting/process --engine-model
```
## Testing

To run the specs you need to execute, in the root path of the engine, the following command:

```bash
bundle exec guard
```

You need to put **all your tests** in the `/metagem/spec` directory.

## Publishing

On master/main branch...

1. Change `VERSION` in `lib/metagem/version.rb`.
2. Change `Unreleased` title to current version in `CHANGELOG.md`.
3. Run `bundle install`.
4. Commit new release. For example: `Releasing v0.1.0`.
5. Create tag. For example: `git tag v0.1.0`.
6. Push tag. For example: `git push origin v0.1.0`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Credits

Thank you [contributors](https://github.com/platanus/metagem/graphs/contributors)!

<img src="http://platan.us/gravatar_with_text.png" alt="Platanus" width="250"/>

Metagem is maintained by [platanus](http://platan.us).

## License

Metagem is © 2021 platanus, spa. It is free software and may be redistributed under the terms specified in the LICENSE file.
