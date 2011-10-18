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
    @bewerbung = Bewerbung.new
  end

  def create
    @bewerbung = Bewerbung.new(params[:bewerbung])

    if @Bewerbung.save
      redirect_to @bewerbung, notice: 'Bewerbung wurde erfolgreich erstellt.'
    else
      render action: "new" 
    end
  end
end
