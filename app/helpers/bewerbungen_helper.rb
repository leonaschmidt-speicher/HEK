module BewerbungenHelper
  def errors? methods
    not methods.map do |method|
      @bewerbung.errors[method]
    end.flatten.empty?
  end

  def errors_for_methods methods
    html = ''
    if errors? methods
      html << '<ol class="errors">'
      methods.each do |method|
        html << error_message_on(@bewerbung, method.to_sym, :html_tag =>'li', :prepend_text => t("helpers.label.bewerbung.#{method}", :default => method.to_s.humanize) + " ")
      end
      html << '</ol>'
      html.html_safe
    end
  end
  
  def step_has_errors? step
    has_error = false 
    case step
    when :persoenliches
      has_error = true unless ( errors_for_methods(Bewerbung::PERSOENLICHE_ANGABEN).blank? \
                    && errors_for_methods(Bewerbung::ANSCHRIFT_DER_ELTERN).blank? \
                    && errors_for_methods(Bewerbung::WEITERE_KONTAKTINFORMATIONEN).blank? \
                    && errors_for_methods(Bewerbung::ANGABEN_ZUM_STUDIUM).blank? )
    when :organisatorisches
      has_error = true unless ( errors_for_methods(Bewerbung::ANGABEN_ZUM_EINZUG).blank? \
                    && errors_for_methods(Bewerbung::VORSTELLUNG).blank? \
                    && errors_for_methods(Bewerbung::ORGANISATORISCHE_MITTEILUNGEN).blank? )
    when :information
      has_error = true unless ( errors_for_methods(Bewerbung::INFORMATIONEN).blank? )
    end
    
    has_error
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
