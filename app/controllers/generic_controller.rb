class GenericController < ApplicationController
  def show
    @group = params[:group]
    @site = params[:site]
    render "#{@group || 'startseite'}/#{@site}"
  rescue ActionView::MissingTemplate
    render :text => ':)' #:status => :not_found
  end

  # ZenPhoto benötigt Navigation.
  def navigation
    render :partial => 'layouts/navigation'
  end
end