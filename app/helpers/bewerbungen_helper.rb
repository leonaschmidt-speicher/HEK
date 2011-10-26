module BewerbungenHelper
  def errors? methods
    not methods.map do |method|
      @bewerbung.errors[method]
    end.flatten.empty?
  end

  def errors_for_methods methods
    if errors? methods
      html = '<ol class="errors">'
      methods.each do |method|
        html << error_message_on(@bewerbung, method.to_sym, :html_tag =>'li', :prepend_text => t("helpers.label.bewerbung.#{method}", :default => method.to_s.humanize) + " ")
      end
      html << '</ol>'
      html.html_safe
    end
  end

  def step_has_errors? step
    not errors_for_methods(methods_for_step step).blank?
  end

  def methods_for_step step
    case step
    when :persoenliches
      Bewerbung::PERSOENLICHE_ANGABEN + Bewerbung::ANSCHRIFT_DER_ELTERN + Bewerbung::WEITERE_KONTAKTINFORMATIONEN + Bewerbung::ANGABEN_ZUM_STUDIUM
    when :organisatorisches
      Bewerbung::ANGABEN_ZUM_EINZUG + Bewerbung::VORSTELLUNG + Bewerbung::ORGANISATORISCHE_MITTEILUNGEN
    when :informationen
      Bewerbung::INFORMATIONEN
    end
  end

  def first_step_with_errors
    if step_has_errors? :persoenliches
      'persoenliches'
    elsif step_has_errors? :organisatorisches
      'organisatorisches'
    else
      'motivation'
    end
  end
end