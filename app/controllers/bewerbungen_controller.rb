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
    
    if not @bewerbung.foto.file? and not params[:already_attached_foto].blank?
      # preserve previousely uploaded foto
      begin
        @bewerbung.foto = File.open("#{Rails.root}/public/uploads/#{sanitize_filename(params[:already_attached_foto].first)}");
      rescue
        @bewerbung.foto = nil
      end
    end
    
    if not @bewerbung.lebenslauf.file? and not params[:already_attached_cv].blank?
      # preserve previousely uploaded cv
      begin
        @bewerbung.lebenslauf = File.open("#{Rails.root}/public/uploads/#{sanitize_filename(params[:already_attached_cv].first)}");
      rescue
        @bewerbung.lebenslauf.nil
      end
    end
    
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
  
  private
  def sanitize_filename(filename)
    filename.strip.tap do |name|
      # NOTE: File.basename doesn't work right with Windows paths on Unix
      # get only the filename, not the whole path
      name.sub! /\A.*(\\|\/)/, ''
      # Finally, replace all non alphanumeric, underscore
      # or periods with underscore
      name.gsub! /[^\w\.\-]/, '_'
    end
  end
end
