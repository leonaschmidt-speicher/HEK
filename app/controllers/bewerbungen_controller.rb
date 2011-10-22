# encoding: utf-8
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
    @bewerbung = (Bewerbung.find(session[:bewerbung_id]) unless session[:bewerbung_id].blank?)|| Bewerbung.new
  end

  def create
    @bewerbung = Bewerbung.new(params[:bewerbung])

    if @bewerbung.save
      session[:bewerbung_id] = @bewerbung.id
      redirect_to :action => 'new', :anchor => 'bestaetigung'
    else
      @group = 'bewerbung'
      render 'new'
    end
  end
  
  def confirm
    if bewerbung = (Bewerbung.find(session[:bewerbung_id]) unless session[:bewerbung_id].blank?)
      bewerbung.bestaetigt = true
      bewerbung.save
      
      # prevent user from submitting his application twice but call him by his name.
      session[:bewerbung_id] = nil
      session[:name] = bewerbung.vorname + bewerbung.nachname
      
      redirect_to :action => 'new', :anchor => 'ablauf'
    else
      redirect_to :action => 'new'
    end
    
  end
end
