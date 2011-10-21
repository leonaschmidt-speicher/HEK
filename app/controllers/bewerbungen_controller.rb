class BewerbungenController < ApplicationController

  def index
    @bewerbungen = Bewerbung.all

    respond_to do |format|
      format.html # index.html.erb
      format.rss { render json: @bewerbungen }
    end
  end

  def show
    @bewerbung = Bewerbung.find(params[:id])
  end

  def new
    @group = 'bewerbung'
    #@bewerbung = session[:bewerbung] || Bewerbung.new
    @bewerbung = Bewerbung.new
  end

  def create
    @bewerbung = Bewerbung.new(params[:bewerbung])

    if @bewerbung.valid?
      #session[:bewerbung] = @bewerbung
      #redirect_to :action => 'new', :anchor => 'bestaetigung'
      @group = 'bewerbung'
      render 'new'
    else
      #session[:bewerbung] = @bewerbung
      #redirect_to :action => 'new', :anchor => 'bestaetigung'

      @group = 'bewerbung'
      render 'new'
    end
  end
end
