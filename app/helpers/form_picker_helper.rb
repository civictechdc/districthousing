module FormPickerHelper
  def labeled_text_field builder, attr, attr_label=attr.to_s.humanize
    builder.label(attr, attr_label) + builder.text_field(attr)
  end
end
