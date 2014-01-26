# McpCommon

## Building this Gem

- had to copy over bootstrap PNGs for icons to the assets/images dir of this gem to get them to appear

## Using in an Application

For the purpose of this document, an "application" means a full rails application OR an engine test application found in spec/dummy, test/dummy, etc.

## Gems

Common functionality is provided by many gems included in McpCommon, however, these gems also need to be included in any application. The following gems are required to be included in the application's Gemfile:

* bootstrap-saas

## Configuration

### Javascripts:

The application needs to provide jquery, jquery-ui and jquery_ujs (the default)
Any other engines in the application need to NOT import these libraries
Common will include all other gem's javascripts, including dataTables, chosen, etc.


# Features


## Mcp Initializer

In config/initalizers is mcp.rb which parses Rails in-memory list of installed 'mcp' engines for the application and installs creates a static variable containing a reference to each 'mcp' engine

The initializer recognizes 'mcp' engines by checking if the respond_to? :mcp which they will do when they have that method defined in lib/<engine name>.rb


## API Controller

includes two files: lib/mcp_common/api_constraints.rb and controllers/mcp_common/api/api_controller.rb
these files are loaded on startup from lib/mcp_common.rb


## Application Layout, Menus and Notification

The main app's ApplicationController should delegate the layout to McpCommon:

layout "layouts/mcp_common/application"

McpCommon's layout:
- creates a layout with CSS classes suitable for Twitter Bootstrap
- will load JS and CSS from all loaded Mcp Engines on each request
- renders each 'mcp' engine's _navigation.html.erb
- renders _messages.html.erb which displays notifications to user so the form doesn't have to


## MultiTab

Renders one or more Twitter Bootstrap horizontal tab(s) and corresponding <div> for rendering a dataTable as content onto an html <table>

The feature includes ERB partials and a CoffeeScript file

The partials responsible for rendering are: multi_tab/_layout, multi_tab/_tabs and multi_tab/tables
The JS is multi_tab.js.coffee

An example can be found in McpPbx engine in app/views/mcp_pbx/cdrs/index.html.erb

