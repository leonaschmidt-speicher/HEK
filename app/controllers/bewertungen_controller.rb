class BewertungenController < ApplicationController
  before_filter :authenticate

  def create
    @bewerbung = Bewerbung.find params[:bewerbung_id]
    @bewertung = @bewerbung.bewertungen.find_or_initialize_by_benutzer :benutzer => @user
    @bewertung.wert = params[:wert]
    @bewertung.save

    @bewerbung.update_bewertung

    render :json => {:wert => @bewerbung.bewertung}
  end
end