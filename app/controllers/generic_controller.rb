class GenericController < ApplicationController
  def show
    @group = params[:group]
    @site = params[:site]
    render "#{@group}/#{@site || 'index'}"
  end
end