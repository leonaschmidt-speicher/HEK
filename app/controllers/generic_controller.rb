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
    @site = nil

    respond_to do |format|
      format.html { render '/nicht-gefunden', :status => :not_found }
      format.all  { render :nothing => true, :status => :not_found }
    end
  end
end