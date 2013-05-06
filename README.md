[![Build Status](https://travis-ci.org/southpolesteve/api_engine.png?branch=master)](https://travis-ci.org/southpolesteve/api_engine)
[![Code Climate](https://codeclimate.com/github/southpolesteve/api_engine.png)](https://codeclimate.com/github/southpolesteve/api_engine)
[![Dependency Status](https://gemnasium.com/southpolesteve/api_engine.png)](https://gemnasium.com/southpolesteve/api_engine)

An API engine for Rails. Convention over configuration. Auto generated docs (coming soon!)

You should use this gem if:
- You want to add an API to your Rails app in just a few lines of code
- You don't want to spend time writing controller code for your API
- You want an API compatible with [Ember Data](https://github.com/emberjs/data)

## Installation

1. Add `gem "api_engine", "~> 0.0.1"` to your gem file
2. Generate an initializer: `rails generate api_engine:config`
3. Add `mount ApiEngine::Engine => "/api"` to your routes file

## Configuration

By default all of your models will be exposed in a bulk REST API at `/api/:model_name`. To expose only certain models, use the whitelist config option:

``` ruby
ApiEngine.configure do |config|
  config.whitelist = [:comment] # Exposes only the 'Comment' model via the API
end
```

## Authentication
Coming soon! There is an open issue for this

## Other Gems

Looking for some other resources for creating more complex APIs? Check out these gems...

- https://github.com/intridea/grape
- https://github.com/polleverywhere/cerealizer
- https://github.com/apotonick/roar
- https://github.com/mavenlink/brainstem

## Contributing

Creating an issue is good. Sending a pull request is better.

## License and Copyright

Copyright 2013 Steven Faulkner

Released under the MIT License. See LICENSE.md for full text


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/southpolesteve/api_engine/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

