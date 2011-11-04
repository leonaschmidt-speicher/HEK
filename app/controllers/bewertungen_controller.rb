class BewertungenController < ApplicationController
  before_filter :authenticate

  def create
    @bewertung = Bewertung.find_or_initialize_by_bewerbung_id_and_benutzer :bewerbung_id => params[:bewerbung_id], :benutzer => @user
    @bewertung.wert = params[:wert]
    @bewertung.save

    @bewerbung = Bewerbung.find params[:bewerbung_id]
    @bewerbung.update_bewertung

    render :json => { :wert => @bewerbung.bewertung }
  end
end