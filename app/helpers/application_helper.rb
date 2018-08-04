# frozen_string_literal: true

module ApplicationHelper
  def page_header(content)
    content_for(:page_header) do
      content_tag('div', class: 'page-header') do
        content_tag('h1', content)
      end
    end
  end

  def side_nav_link_to(body, url, id: nil)
    content_for(:side_nav) { content_tag('li', link_to(body, url, id: id, class: 'nav-link'), class: 'nav-item') }
  end

  def main_nav_link(body, url, method: nil)
    li_class = 'nav-item'
    li_class += ' active' if current_page?(url)
    content_tag('li', link_to(body, url, method: method, class: 'nav-link'), class: li_class)
  end

  def edit_icon(object, html_options = {})
    link_to(content_tag('i', '', class: 'icon-edit'),
            { action: 'edit', id: object },
            html_options.reverse_merge(title: 'Edit', id: dom_id(object, :edit)))
  end

  def can?(action, model)
    policy(model).public_send("#{action}?".to_sym)
  end
end
