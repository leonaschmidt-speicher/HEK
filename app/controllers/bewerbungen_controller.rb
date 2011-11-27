class BewerbungenController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :set_group

  def index
    @bewerbungen = Bewerbung.nicht_abgesagt.includes(:bewertungen).order params[:sort_by], 'created_at desc'
    @bewerbungen.where! :geschlecht => params[:geschlecht] unless params[:geschlecht].blank?
    @bewerbungen.where! 'wunsch = :einzugsdatum or (fruehestens <= :einzugsdatum and :einzugsdatum <= spaetestens)', :einzugsdatum => Time.zone.parse(params[:einzugsdatum]).strftime('%Y-%m-%d') unless params[:einzugsdatum].blank?
    @bewerbungen.where! "#{'not' if params[:staatsangehoerigkeit] == 'nicht-deutsch'} staatsangehoerigkeit like 'deutsch%'" unless params[:staatsangehoerigkeit].blank?
    @bewerbungen.where! :zugesagt => params[:zugesagt] unless params[:zugesagt].blank?

    respond_to do |format|
      format.html # index.html.erb
      format.atom
    end
  end

  def show
    @bewerbung = Bewerbung.includes(:bewertungen).find params[:id]
  end

  def new
    @bewerbung = Bewerbung.nicht_bestaetigt.find_or_initialize_by_id session[:bewerbung_id]
  end

  def create
    @bewerbung = Bewerbung.nicht_bestaetigt.find_or_initialize_by_id session[:bewerbung_id]
    @bewerbung.attributes = params[:bewerbung]

    @bewerbung.recover :temp_foto, params[:already_attached_foto]
    @bewerbung.recover :temp_lebenslauf, params[:already_attached_lebenslauf]

    if @bewerbung.save
      session[:bewerbung_id] = @bewerbung.id
      redirect_to :action => 'new', :anchor => 'bestaetigung'
    else
      # validation errors would prevent the uploaded files to be saved. save them manually
      @bewerbung.save_attached_files
      render 'new'
    end
  end

  alias_method :update, :create

  def bestaetigen
    @bewerbung = Bewerbung.nicht_bestaetigt.find session[:bewerbung_id]
    @bewerbung.bestaetigt = true

    # move attachments to a secure place
    @bewerbung.foto = @bewerbung.temp_foto
    @bewerbung.temp_foto.clear
    @bewerbung.lebenslauf = @bewerbung.temp_lebenslauf
    @bewerbung.temp_lebenslauf.clear

    @bewerbung.save

    # prevent user from submitting his application twice but call him by his name.
    session[:bewerbung_id] = nil
    session[:name] = @bewerbung.name

    redirect_to :action => 'new', :anchor => 'ablauf'
  end

  def zusagen
    @bewerbung = Bewerbung.find params[:id]
    @bewerbung.update_attribute :zugesagt, true

    redirect_to :action => 'show'
  end

  def absagen
    @bewerbung = Bewerbung.find params[:id]
    @bewerbung.update_attribute :zugesagt, false

    redirect_to :action => 'show'
  end

private
  def set_group
    @group = 'bewerbung'
  end
end
