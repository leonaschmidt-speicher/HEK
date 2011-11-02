class BewertungenController < ApplicationController
  before_filter :authenticate

  def create
    @bewerbung = Bewerbung.find params[:bewerbung_id]
    @bewertung = @bewerbung.bewertungen.find_or_initialize_by_benutzer :benutzer => @user
    @bewertung.wert = params[:wert]
    @bewertung.save

    bewertung = (@bewerbung.bewertungen.map(&:wert).sum / @bewerbung.bewertungen.count).round
    @bewerbung.update_attribute :bewertung, bewertung

    render :json => @bewertung
  end
end