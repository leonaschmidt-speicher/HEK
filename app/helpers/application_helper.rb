module ApplicationHelper
  def site_id
    if @site == 'index'
      @group
    else
      if @site == 'treffen' || @site == 'feste'
        'veranstaltungen'
      else 
        @site
      end
    end
  end
end
