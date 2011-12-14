class KommentareController < ApplicationController
  before_filter :authenticate

  def create
    @bewerbung = Bewerbung.find params[:bewerbung_id]
    @kommentar = @bewerbung.kommentare.build params[:kommentar]
    @kommentar.benutzer = @user
    @kommentar.save

    respond_to do |format|
      format.html { redirect_to @bewerbung }
      format.js
    end
  end

  def destroy
    @bewerbung = Bewerbung.find params[:bewerbung_id]
    @kommentar = @bewerbung.kommentare.find params[:id]
    @kommentar.destroy

    respond_to do |format|
      format.html { redirect_to @bewerbung }
      format.js
    end
  end
end