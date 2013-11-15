module McpCommon
  module ApplicationHelper


    #private

    # 
    # Identify user agent as a mobile device
    # See: http://railscasts.com/episodes/199-mobile-devices?view=asciicast
    #
    def mobile_device?
      request.user_agent =~ /iPhone|Android/
    end

    def tablet?
      request.user_agent =~ /iPad/
    end


    # 
    # Render a Twitter Bootstrap button group for a controller context menu
    #
    def mcp_button_group(opts = {}, &block)
      content = capture(&block) 
      content_tag(:div, class: "btn-group") do
        ( "<button id='#{opts[:name]}' class='btn #{opts[:class]}' data-toggle='#{opts[:toggle]}'>#{opts[:name]}</button>" +
          "<button class='btn dropdown-toggle #{opts[:class]}' data-toggle='dropdown'><span class='caret'></span></button>" +
          content_tag(:ul, content, class: "dropdown-menu")
        ).html_safe
      end
    end

    # 
    # Render a Twitter Bootstrap compatible JS menu
    # See: http://railscasts.com/episodes/208-erb-blocks-in-rails-3
    #
    def top_menu(name, &block)
      content = capture(&block) 
      content_tag(:li, class: "dropdown") do
        ("<a href='#' class='dropdown-toggle' data-toggle='dropdown'>#{name}<b class='caret'></b></a>" +
        content_tag(:ul, content, class: "dropdown-menu")).html_safe
      end
    end



    def nav_tab opts
      active = ''
      active = 'active' if params[:tab] and params[:tab].to_i.eql? opts[:index]
      active = 'active' if not params[:tab] and opts[:default].eql? true
      "<li class='#{active}'><a href='#tab#{opts[:index]}' data-toggle='tab'>#{opts[:text]}</a></li>".html_safe
    end

def box_wrapper(&block)  
  content = capture(&block)  
  content_tag(:div, content, :class => 'box')  
end
    def tab_pane opts, &block
      content = capture(&block)  
      active = ''
      active = 'active' if params[:tab] and params[:tab].to_i.eql? opts[:index]
      active = 'active' if not params[:tab] and opts[:default].eql? true
      content_tag(:div, content, class: "tab-pane #{active}", id: "tab#{opts[:index]}")
    end


    # 
    # Render partials from every 'mcp' engine an optionally skip one or more engines
    #
    def mcp_engines_render_partial (path, opts = {})
      dir, file = path.split('/')
      skip = opts.delete(:skip) || []
      skip = [skip] if skip.is_a? Symbol
      skip = [skip.to_sym] if skip.is_a? String
      c = ''
      APPLICATION_ENGINES.each do |engine|
        lookup_path = dir.eql?('layouts') ? "#{dir}/#{engine[:name]}" : "#{engine[:name]}/#{dir}"
        if not skip.include? engine[:name].to_sym and lookup_context.template_exists?(file, lookup_path, true)
          c = c + render(partial: "#{lookup_path}/#{file}", locals: opts[:locals])
        end
      end
      c.html_safe
    end

  end
end

