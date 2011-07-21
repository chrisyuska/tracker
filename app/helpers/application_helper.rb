module ApplicationHelper
  def nav_links(links)
    link_html = ""
    links.each do |link|
      class_name = ""
      class_name << "current" if params[:controller] == link[:text].downcase
      link_html << content_tag("li", link_to(link[:text], link[:url]), :class => class_name)
    end
    return content_tag("ul", raw(link_html), :id => "nav")
  end
end
