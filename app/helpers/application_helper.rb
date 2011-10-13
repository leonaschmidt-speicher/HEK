# encoding: utf-8
module ApplicationHelper
  def site_id
    (@site || @group || 'startseite').sub /treffen|feste/, 'veranstaltungen'
  end

  def site_title
    # Alternativ könnte man den Titel auch in de.yml unter config/locales setzen.
    (@site || @group).titleize + ' ♣ ' unless @group.blank?
  end
end