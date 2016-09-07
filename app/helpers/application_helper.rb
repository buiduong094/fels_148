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
    datetime.strftime(t :"datetime.formats.default", {locale: I18n.locale})
  end

  def link_to_function name, *args, &block
    html_options = args.extract_options!.symbolize_keys

    function = block_given? ? update_page(&block) : args[0] || ""
    onclick = "#{"#{html_options[:onclick]}; " if
      html_options[:onclick]}#{function}; return false;"
    href = html_options[:href] || "#"

    content_tag :a, name,
      html_options.merge(:href => href, :onclick => onclick)
  end

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)",
      :class => "btn remove danger")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object,
      :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name,
      "add_fields(this, '#{association}', '#{escape_javascript(fields)}')",
      :class => "btn")
  end

  def get_object_by_id model, id
    result = model.find_by id: id
    result.nil? ? redirect_to(root_path) : result
  end

  def lession_complete_button lesson
    lesson.is_complete? ? t("page.users.profile.stt_finish") :
      t("page.users.profile.stt_continue")
  end
end
