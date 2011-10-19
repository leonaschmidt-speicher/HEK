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
    @bewerbung = Bewerbung.new
    render '/bewerbung'
  end

  def create
    @bewerbung = Bewerbung.new(params[:bewerbung])

    if @bewerbung.save
      redirect_to @bewerbung, notice: 'Bewerbung wurde erfolgreich erstellt.'
    else
      @group = 'bewerbung'
      render '/bewerbung' 
    end
  end
end
