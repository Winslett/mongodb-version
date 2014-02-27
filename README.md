# Mongodb::Version

Use this gem to ask questions of MongoDB versions.  You can compare versions, and determine capabilities.

## Installation

Add this line to your application's Gemfile:

    gem 'mongodb-version'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongodb-version

## Usage

    MongoDB::Version['2.4.6'].ttl_collections? => true
    MongoDB::Version['2.0.6'].ttl_collections? => false

    MongoDB::Version['2.6.0'].authentication_schemes => [2]
    MongoDB::Version['2.4.6'].authentication_schemes => [1,2]
    MongoDB::Version['2.2.6'].authentication_schemes => [1]

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
