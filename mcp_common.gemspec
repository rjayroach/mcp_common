$:.push File.expand_path("../lib", __FILE__)

# See: http://stackoverflow.com/questions/5159607/rails-engine-gems-dependencies-how-to-load-them-into-the-application

# Gem vs gemspec:
# See: http://yehudakatz.com/2010/12/16/clarifying-the-roles-of-the-gemspec-and-gemfile/
#
# The gemspec here specifies gems that other engines and the app depends on
# The application's Gemfile.lock will specify the exact version of gems required in the app

# Specify gem version details:
# See: http://docs.rubygems.org/read/chapter/16
# Also see: http://stackoverflow.com/questions/5170547/what-does-tilde-greater-than-mean-in-ruby-gem-dependencies
# Also see: http://gembundler.com/man/gemfile.5.html


# Maintain your gem's version:
require "mcp_common/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "mcp_common"
  s.version     = McpCommon::VERSION
  s.authors     = ["Robert Roach"]
  s.email       = ["robert.roach@maxcole.com"]
  s.homepage    = "http://www.maxcole.com"
  s.summary     = "Provides functionality required by other 'Mcp' gems"
  s.description = "Description of McpCommon."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

#=begin # Rails 3
  s.add_dependency "bootstrap-sass", "= 2.3.2.2"
  s.add_dependency "chosen-rails" #, "~> 0.2.0"
  s.add_dependency "draper"
  s.add_dependency "geocoder" #, "~> 0.2.0"
  s.add_dependency "exception_notification", "= 3.0.1"
  s.add_dependency "jquery-datatables-rails", "~> 1.11.2"
  s.add_dependency "money-rails", ">= 0.8.0"
  s.add_dependency "will_paginate", ">= 3.0.3"
  s.add_dependency "rabl", "~> 0.8.0"
  s.add_dependency "rails", "~> 3.2.14"
  s.add_dependency "ransack", "~> 0.7.2"
  s.add_dependency "simple_form", "~> 2.1.0"
  s.add_dependency "strong_parameters", "~> 0.2.0"
  s.add_dependency "sucker_punch", "~> 1.0.0"
  s.add_dependency "whenever" #, "~> 0.2.0"
  s.add_dependency "draper"
#=end # Rails 3

=begin # Rails 4
  s.add_dependency "rails", "~> 4.0.0"
=end # Rails 4

  # s.add_dependency "jquery-rails"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "commands"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
end



