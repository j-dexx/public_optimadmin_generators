# OptimadminGenerators

A generator to generate admin views

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'optimadmin_generators', git: 'git@github.com:eskimosoup/optimadmin_generators.git'
```

And then execute:

    $ bundle

## Usage

Example:
    rails generate optimadmin:admin Thing

    This will create:
        controllers/optimadmin/things_controller.rb
        views/optimadmin/things/index.html.erb
        views/optimadmin/things/new.html.erb
        views/optimadmin/things/edit.html.erb
        views/optimadmin/things/_form.html.erb

    rails generate admin Thing title image:image document:document display:boolean

    This will create all the things above but setup image_field for the image, document_field for the document and all booleans will go into
    the settings section of the form

### Other generators

  * optimadmin:seo
  * optimadmin:page
  * optimadmin:error_messages

## Useful links
  [Rails scaffold controller](https://github.com/rails/rails/blob/master/railties/lib/rails/generators/rails/scaffold_controller/templates/controller.rb)
  [Strip heredoc](http://guides.rubyonrails.org/active_support_core_extensions.html#strip-heredoc)
  https://ludostudio.teamwork.com/notebooks/82708

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

1. Fork it ( https://github.com/[my-github-username]/optimadmin_generators/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
