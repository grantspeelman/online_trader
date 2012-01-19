module ApplicationHelper

  def side_nav_link_to(body, url, html_options = {})
    content_for(:side_nav){content_tag("li",link_to(body, url, html_options))}
  end

  def main_nav_link(body, url, html_options = {})
    li_class = nil
    li_class = "active" if current_page?(url)
    content_tag("li",link_to(body, url, html_options),:class => li_class)
  end

end
