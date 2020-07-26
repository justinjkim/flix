module ApplicationHelper
  def nav_link_to(text, url)
    current_page?(url) ? link_to(text, url, class: "active") : link_to(text, url)
  end
end
