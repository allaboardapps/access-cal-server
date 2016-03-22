module ApplicationHelper
  def title(page_title)
    content_for(:title) { page_title }
  end

  def copyright_notice
    "&copy; 2016 Access Cal"
  end

  def number_with_leading(integer)
    "%.2d" % integer
  end
end
