require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

# --- Instructions ---
# Sort the contents of this file into a Spork.prefork and a Spork.each_run
# block.
#
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
#
# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
#
# Note: You can modify files loaded *from* the Spork.each_run block without
# restarting the spork server.  However, this file itself will not be reloaded,
# so if you change any of the code inside the each_run block, you still need to
# restart the server.  In general, if you have non-trivial code in this file,
# it's advisable to move it into a separate file so you can easily edit it
# without restarting spork.  (For example, with RSpec, you could move
# non-trivial code into a file spec/support/my_helper.rb, making sure that the
# spec/support/* files are require'd from inside the each_run block.)
#
# Any code that is left outside the two blocks will be run during preforking
# *and* during each_run -- that's probably not what you want.
#
# These instructions should self-destruct in 10 seconds.  If they don't, feel
# free to delete them.


Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  
  require 'simplecov'
  SimpleCov.start 'rails' do
    add_filter '/spec/'
    add_filter '/config/'
    add_filter '/lib/'
    add_filter '/vendor/'
   
    add_group 'Controllers', 'app/controllers'
    add_group 'Models', 'app/models'
    add_group 'Helpers', 'app/helpers'
    add_group 'Mailers', 'app/mailers'
    add_group 'Views', 'app/views'
  end


  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../dummy/config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'shoulda-matchers'
  
  require 'capybara/rspec'
  require 'factory_girl'
  require 'faker'
  require 'timecop'
  
  require 'database_cleaner'


  # For headless JS testing
  # Requires PhantomJS to be installed:
  # wget http://phantomjs.googlecode.com/files/phantomjs-1.7.0-source.zip
  # unzip -q; cd phantom-1.7 and run ./build.sh
  # ln -s /usr/local/src/phantomjs-1.7.0/bin/phantomjs /usr/local/bin/phantomjs
  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist
  #Capybara.default_wait_time = 5
  
  ENGINE_RAILS_ROOT=File.join(File.dirname(__FILE__), '../')
  
  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[File.join(ENGINE_RAILS_ROOT, "spec/support/**/*.rb")].each {|f| require f }
  
  # Require factory files from the factories folder because factories are in a separate directory
  Dir[File.join(ENGINE_RAILS_ROOT, "spec/factories/**/*.rb")].each {|f| require f}


  require 'vcr'

  VCR.configure do |config|
    config.cassette_library_dir = File.join(ENGINE_RAILS_ROOT, "spec", "fixtures", "vcr")
    config.hook_into :webmock
    config.default_cassette_options = { record: :new_episodes }
    #c.stub_with :fakeweb
    #c.filter_sensitive_data('<WSDL>') { "http://www.webservicex.net:80/uszip.asmx?WSDL" }
  end

  
  RSpec.configure do |config|

    config.filter_run_excluding skip: true


    # Cause all jobs to be performed synchronously
    require 'sucker_punch/testing/inline'


    # Include Factory Girl syntax to simplify calls to factories
    config.include FactoryGirl::Syntax::Methods
  
    # Add the next line so capybara visit <url_helper> works
    config.include McpCommon::Engine.routes.url_helpers

    # From support/mailer_macros.rb
    # See: http://railscasts.com/episodes/275-how-i-test?view=asciicast
    config.include(MailerMacros)

    # FIX: Include the engine routes so controller and request specs pass
    config.before(:each) {
      @routes = McpCommon::Engine.routes
      reset_email  # See: http://railscasts.com/episodes/275-how-i-test?view=asciicast
    }
  
    # ## Mock Framework
    #
    # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
    #
    # config.mock_with :mocha
    # config.mock_with :flexmock
    # config.mock_with :rr
  
    # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
    #  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
    # If you're not using ActiveRecord, or you'd prefer not to run each of your
    # examples within a transaction, remove the following line or assign false
    # instead of true.
    # config.use_transactional_fixtures = true

    # rr - Changes to enable request specs with capybara to test JS and accurately report database results
    # See: http://railscasts.com/episodes/257-request-specs-and-capybara?view=asciicast
    config.use_transactional_fixtures = false

    config.before(:suite) do
      DatabaseCleaner.app_root = "#{ENGINE_RAILS_ROOT}spec/dummy"
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.strategy = :transaction
    end

    config.before(:each, job: true) do
      DatabaseCleaner.strategy = :truncation
      #DatabaseCleaner.strategy = :deletion
    end

    config.before(:each, js: true) do
      DatabaseCleaner.strategy = :truncation
    end

    config.before(:each) do
      DatabaseCleaner.start
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end


  
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
  end

end


# This code will be run each time you run your specs.
Spork.each_run do
  ActiveSupport::Dependencies.clear
  FactoryGirl.reload

  # reload all the models
  Dir[File.join(ENGINE_RAILS_ROOT, "/app/models/**/*.rb")].each do |model|
    load model
  end

  # reload routes
  Rails.application.reload_routes!
end


