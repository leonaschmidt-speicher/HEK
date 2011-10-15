class GenericController < ApplicationController
  def show
    @group = params[:group]
    @site = params[:site]
    render "#{@group || 'startseite'}/#{@site}"
  end

  # ZenPhoto benötigt Navigation.
  def navigation
    render :partial => 'layouts/navigation'
  end
end