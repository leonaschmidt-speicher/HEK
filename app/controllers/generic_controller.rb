class GenericController < ApplicationController
  def show
    @group = params[:group]
    @site = params[:site]
    render "#{@group}/#{@site || 'index'}"
  end

  # ZenPhoto benötigt Navigation.
  def navigation
    render :partial => 'layouts/navigation'
  end
end