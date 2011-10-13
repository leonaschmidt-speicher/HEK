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
      else 
        @site
      end
    end
  end

  #def page_title= title <-- why can't I use this method name and then page_title = 'asdf' in the view?
  def page_title title
    #provide :title, title + ' ♣ ' <-- gives a syntax error only when using this special character
    provide :title, title + ' KREUZ '
  end
end
