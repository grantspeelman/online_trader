module ApplicationHelper

  def side_nav_link_to(body, url, html_options = {})
    content_for(:side_nav){content_tag("li",link_to(body, url, html_options))}
  end

end
