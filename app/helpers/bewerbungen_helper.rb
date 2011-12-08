# encoding: utf-8
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
        unless @bewerbung.errors[method].empty?
          html << "<li><label for='bewerbung_#{method}'>"
          html << @bewerbung.errors[method].first
          html << '</label></li>'
        end
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
    when :motivation
      Bewerbung::MOTIVATION
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

  def sortable_link_to name, attribute
    if params[:sort_by].try :start_with?, attribute
      name += params[:sort_by].end_with?(' desc') ? ' ▼' : ' ▲'
    end
    link_to name, bewerbungen_path(params.merge(:sort_by => sort_by(attribute)))
  end

  def sort_by attribute
    if params[:sort_by] == "#{attribute} desc"
      "#{attribute} asc"
    else
      "#{attribute} desc"
    end
  end
end