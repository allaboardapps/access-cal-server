module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def copyright_notice
    "&copy; ".html_safe + Time.new.strftime("%Y") + " Events Server. All Rights Reserved"
  end

  def number_with_leading(integer)
    "%.2d" % integer
  end
end
