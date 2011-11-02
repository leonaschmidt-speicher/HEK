class BewerbungenController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]

  def index
    @group = 'bewerbung'
    @sort_by = (params[:sort_by].blank? ? '' : "#{params[:sort_by]}, ") + 'created_at desc'
    # zugesagt ist wirklich ein schlechter Name ...
    @bewerbungen = Bewerbung.where(:zugesagt => [true, nil]).order @sort_by
    @bewerbungen = @bewerbungen.where :geschlecht => params[:geschlecht] unless params[:geschlecht].blank?
    @bewerbungen = @bewerbungen.where '(fruehestens <= :einzugsdatum and :einzugsdatum <= spaetestens) or wunsch = :einzugsdatum', :einzugsdatum => Time.zone.parse(params[:einzugsdatum]).strftime('%Y-%m-%d') unless params[:einzugsdatum].blank?
    @bewerbungen = @bewerbungen.where "#{'not' if params[:staatsangehoerigkeit] == 'nicht-deutsch'} staatsangehoerigkeit = 'deutsch'" unless params[:staatsangehoerigkeit].blank?
    @bewerbungen = @bewerbungen.where :zugesagt => params[:zugesagt] unless params[:zugesagt].blank?

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


    if not @bewerbung.temp_foto.file? and not params[:already_attached_foto].blank?
      # preserve previousely uploaded foto
      begin
        @bewerbung.temp_foto = File.open("#{Rails.root}/public/uploads/#{sanitize_filename(params[:already_attached_foto].first)}");
      rescue
        @bewerbung.temp_foto = nil
      end
    end
    if not @bewerbung.temp_lebenslauf.file? and not params[:already_attached_cv].blank?
      # preserve previousely uploaded cv
      begin
        @bewerbung.temp_lebenslauf = File.open("#{Rails.root}/public/uploads/#{sanitize_filename(params[:already_attached_cv].first)}");
      rescue
        @bewerbung.temp_lebenslauf = nil
      end
    end

    if @bewerbung.save
      session[:bewerbung_id] = @bewerbung.id
      redirect_to :action => 'new', :anchor => 'bestaetigung'
    else
      # validation errors would prevent the uploaded files to be saved. save them manually
      @bewerbung.save_attached_files
      @group = 'bewerbung'
      render 'new'
    end
  end

  def confirm
    if bewerbung = (Bewerbung.find(session[:bewerbung_id]) unless session[:bewerbung_id].blank?)
      bewerbung.bestaetigt = true

      # move attachments to a secure place
      bewerbung.foto = bewerbung.temp_foto
      bewerbung.temp_foto.clear
      bewerbung.lebenslauf = bewerbung.temp_lebenslauf
      bewerbung.temp_lebenslauf.clear

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