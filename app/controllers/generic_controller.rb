require 'open-uri'

class GenericController < ApplicationController
  def show
    @group = params[:group]
    @site = params[:site]
    render "#{@group || 'startseite'}/#{@site}"
  rescue ActionView::MissingTemplate
    not_found
  end

  # ZenPhoto benötigt Navigation.
  def navigation
    render :partial => 'layouts/navigation'
  end

  def not_found
    @group = 'nicht-gefunden'
    render '/nicht-gefunden', :status => :not_found
  end
end