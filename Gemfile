source 'https://rubygems.org'

# for chef development core
group :chef_dev do
  gem 'chef'
  gem 'knife-solo'
  gem 'rake'
end

# for chef testing
group :chef_test do
  gem 'rspec'
  gem 'chefspec'
  gem 'minitest'
  gem 'test-kitchen'
end

# for test driven development
group :tdd do
  gem 'guard'
  gem 'guard-chef'
  gem 'guard-foodcritic'
  gem 'terminal-notifier-guard'
  gem 'foodcritic'
  gem 'fauxhai'
end

group :chef_dep do
  gem 'librarian-chef'
  gem 'ffi', '1.9.0'
  gem 'buff-extensions', '0.5.0'
  gem 'berkshelf', '3.1.1'
end
