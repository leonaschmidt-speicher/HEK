class GenericController < ApplicationController
  def show
    @group = params[:group]
    @site = params[:site] || 'index'
    render "#{@group}/#{@site}"
  end
end