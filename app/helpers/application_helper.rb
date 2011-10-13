module ApplicationHelper
  def site_id
    if @site == 'index'
      if not @group
        'startseite'
      else
        @group
      end
    else
      if @site == 'treffen' || @site == 'feste'
        'veranstaltungen' 
        @site
      end
    end
  end
end
