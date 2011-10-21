module BewerbungenHelper
  def errors? methods
    not methods.map do |method|
      @bewerbung.errors[method]
    end.flatten.empty?
  end

  def errors_for_methods form, methods
    html = ''
    if errors? Bewerbung::PERSOENLICHE_ANGABEN
      html << '<ol class="errors">'
      methods.each do |method|
        html << form.error_message_on(method.to_sym, :html_tag =>'li', :prepend_text => t("helpers.label.bewerbung.#{method}", :default => method.to_s.humanize) + " ")
      end
      html << '</ol>'
      html.html_safe
    end
  end

end
