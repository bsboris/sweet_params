# Sweet Params

[![Code Climate](https://codeclimate.com/github/bsboris/sweet_params/badges/gpa.svg)](https://codeclimate.com/github/bsboris/sweet_params)

Syntax sugar for Rails Strong Parameters, making them sweet and tasty to work with.

This plugin protects you from bad practice of using #to_sym on user provided params when comparing with known value (e.g. when using params for filters or scopes):

    if params[:scope].to_sym == :recent
      ...
Symbols are not garbage collectable, so the code above has potential DoS vulnerability.
Attacker can send zillion of long random `[:scope]` params and your server will soon run out of memory.

Of course, you can use strings instead of symbols for known values, but this just doesn't feel right. In Ruby, we used to symbols when naming things.

So here goes Sweet Params, providing convinient (and safe!) methods for working with params using symbols:

    def index
      @posts = if params.has?(:scope, in: :recent)
        Post.recent
      elsif params.has?(:scope, in: %i(archived old))
        Post.old
      else
        Post.all
      end
    end

or using `#validate_to_sym` and `case` statement:

    def index
      @posts = case params.validate_to_sym(:scope, in: %i(recent archived old))
      when :recent then Post.recent
      when :archived, :old then Post.old
      else Post.all
      end
    end

## Installation

Add this line to your application's Gemfile:

    gem 'sweet_params', '~> 0.0.1'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sweet_params

## Usage

Testing whether param is present:

    params.has?(:scope) # => params[:scope].present?

Multidimensional hashes are supported:

    params.has?([:filter, :scope]) # => params[:filter][:scope].present?

Validating params with single:

    params.has?(:scope, in: :recent) #=> params[:scope].to_s == :recent.to_s

... or multiple values:

    params.has?(:scope, in: %i(recent new)) #=> params[:scope].to_s == :recent.to_s or params[:scope].to_s == :new.to_s

Or you can just get the param, ensure that it is allowed and work with it your way:

    params.validate(:scope, in: %i(hot recent)) # => params[:scope] or nil if params is not in whitelist

You can convert param to symbol (but only if it whitelisted)

    params.validate_to_sym(:scope, in: %i(hot recent)) # => params[:scope].to_sym or nil if params is not in whitelist

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
