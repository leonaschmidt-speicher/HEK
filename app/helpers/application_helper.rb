module ApplicationHelper
  def site_id
    if @site == 'index'
      @group
    else
      if @site == 'treffen' || @site == 'feste'
        'veranstaltungen'
      end
    end
  end
end