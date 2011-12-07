# encoding: utf-8
module ApplicationHelper
  def site_id
    (@site || @group || 'startseite').sub /treffen|feste/, 'veranstaltungen'
  end

  def site_title
    # Alternativ könnte man den Titel auch in de.yml unter config/locales setzen.
    if @group.nil?
      'Studentenwohnheim '
    else
      (@site || @group).titleize + ' ♣ '
    end
  end

  def controller? *controllers
    controllers.include? params[:controller].to_sym
  end

  def action? *actions
    actions.include? params[:action].to_sym
  end

  def tutoren tutoriat
    Tutor.where(:tutoriat => tutoriat).order(:zimmernummer).map do |tutor|
      "<dd>#{tutor.vorname.strip} (#{tutor.zimmernummer.try :strip})</dd>"
    end.join("\n").html_safe
  end
end