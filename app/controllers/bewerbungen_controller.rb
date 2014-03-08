class BewerbungenController < ApplicationController
  before_filter :authenticate, :only => [:index, :show]
  before_filter :set_group

  def index
    @bewerbungen = Bewerbung.nicht_abgesagt.aktuell.includes(:bewertungen).order params[:sort_by], 'created_at desc'
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
    @bewerbung = Bewerbung.bestaetigt.new rescue Bewerbung.new
  end

  def create
    @bewerbung = Bewerbung.bestaetigt.new rescue Bewerbung.new
    @bewerbung.attributes = params[:bewerbung]

    @bewerbung.recover :temp_foto, params[:already_attached_foto]
    @bewerbung.recover :temp_lebenslauf, params[:already_attached_lebenslauf]

    if @bewerbung.save
      # now that we know that everything was filled in correctly, we move the attachments to a secure place and delete the others
      @bewerbung.foto = @bewerbung.temp_foto
      @bewerbung.temp_foto.clear
      @bewerbung.lebenslauf = @bewerbung.temp_lebenslauf
      @bewerbung.temp_lebenslauf.clear

      if @bewerbung.save
        session[:name] = @bewerbung.name
        render 'bestaetigung'
      else
        # this branch should never be taken
        render 'new'
      end
    else
      # validation errors would prevent the uploaded files to be saved. save them manually
      @bewerbung.save_attached_files
      render 'new'
    end
  end

  alias_method :update, :create

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