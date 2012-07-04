module ApplicationHelper

  def page_header(content)
    content_for(:page_header) do
      content_tag('div', :class => 'page-header') do
        content_tag('h1',content)
      end
    end
  end

  def side_nav_link_to(body, url, html_options = {})
    content_for(:side_nav){content_tag("li",link_to(body, url, html_options))}
  end

  def main_nav_link(body, url, html_options = {})
    li_class = nil
    li_class = "active" if current_page?(url)
    content_tag("li",link_to(body, url, html_options),:class => li_class)
  end

  def edit_icon(object,html_options = {})
    link_to(content_tag('i','',:class => 'icon-edit'),
            {:action => 'edit', :id => object},
            html_options.reverse_merge(:title => 'Edit', :id => dom_id(object,:edit)))
  end

end
