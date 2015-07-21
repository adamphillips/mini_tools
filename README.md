# MiniTools

[![Build Status](https://travis-ci.org/adamphillips/mini_tools.svg?branch=master)](https://travis-ci.org/adamphillips/mini_tools)

These are some examples of simple patterns in Ruby. Whilst they are installable
using RubyGems, the idea is that they are so simple that you probably just want
to roll your own derivatives rather than add another gem dependency to your
app.

Each contains an example of how to use it. You can also look at the tests for
each of the patterns.

### Command

[view](lib/mini_tools/command.rb)

A simple command object that can also be used for service objects or interactors.

### Configuration

[view](lib/mini_tools/configuration.rb)

A simple configuration store.

### ItemFactory

[view](lib/mini_tools/item_factory.rb)

A simple item factory.

### Response

[view](lib/mini_tools/response.rb)

Works in conjunction with the Command object and represents the response from a command.

## Installing from RubyGems

Install with

```
gem install mini_tools
```

or if you are using bundler, add it to your Gemfile

```
gem 'mini_tools'
```

then run

```
bundle
```
