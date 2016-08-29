module ApplicationHelper
  def full_title page_title = ""
    base_title = t "page.framgia_system"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def localize_time datetime
    datetime.strftime(I18n.t(:"datetime.formats.default", {locale: I18n.locale}))
  end

end
