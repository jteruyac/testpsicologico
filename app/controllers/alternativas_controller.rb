class AlternativasController < ApplicationController
  # GET /alternativas
  # GET /alternativas.xml
  def index
    @alternativas = Alternativa.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @alternativas }
    end
  end

  # GET /alternativas/1
  # GET /alternativas/1.xml
  def show
    @alternativa = Alternativa.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @alternativa }
    end
  end

  # GET /alternativas/new
  # GET /alternativas/new.xml
  def new
    @alternativa = Alternativa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @alternativa }
    end
  end

  # GET /alternativas/1/edit
  def edit
    @alternativa = Alternativa.find(params[:id])
  end

  # POST /alternativas
  # POST /alternativas.xml
  def create

    alternativa = Alternativa.new(params[:alternativa])
    prueba_data = session[:prueba_preguntas]

    if (prueba_data.modificacion == true)
        redirect_to :back

    elsif (prueba_data.modificacion == false)
        identidad = params[:identidad][:id]
        prueba_data.update_alternativa(alternativa, identidad.to_i)

        session[:prueba_preguntas] = prueba_data
        session[:origen] = "new_upd_alternativa"
        flash[:alternat_updt_altid] = 4.to_s  #identidad.to_s
        flash[:alternat_updt_preid] = alternativa.pregunta_id.to_s
        redirect_to new_prueba_path
        
    end

  end

  # PUT /alternativas/1
  # PUT /alternativas/1.xml
  def update
#    prueba_data = session[:prueba_preguntas]
#    alternativa = Alternativa.new(params[:alternativa])
#
#    identidad = params[:identidad][:id] #brinda el dato: identificador_alternativa
#    prueba_data.update_alternativa(alternativa, identidad.to_i)
#
#    session[:prueba_preguntas] = prueba_data
#    session[:origen] = "edit_upd_alternativa"
#    flash[:alternat_updt_altid] = 4.to_s  #identidad.to_s
#    flash[:alternat_updt_preid] = alternativa.pregunta_id.to_s
#    redirect_to :controller => :pruebas, :action => :edit, :id => 10

    
  end

  def update_edit

    alternativa = Alternativa.new(params[:alternativa])#el identificador_pregunta esta en Rasgo.pregunta_id
    prueba_data = session[:prueba_preguntas]

    if (prueba_data.modificacion == true)
        identidad = params[:identidad][:id] #brinda el dato: identificador_alternativa
        prueba_data.update_alternativa(alternativa, identidad.to_i)

        session[:prueba_preguntas] = prueba_data
        session[:origen] = "edit_upd_alternativa"
        flash[:alternat_updt_altid] = 4.to_s  #identidad.to_s
        flash[:alternat_updt_preid] = alternativa.pregunta_id.to_s
        redirect_to :controller => :pruebas, :action => :edit, :id => params[:prueba_psico][:ide]

    elsif (prueba_data.modificacion == false)
        
        redirect_to :back

    end

  end


  # DELETE /alternativas/1
  # DELETE /alternativas/1.xml
  def destroy
    @alternativa = Alternativa.find(params[:id])
    @alternativa.destroy

    respond_to do |format|
      format.html { redirect_to(alternativas_url) }
      format.xml  { head :ok }
    end
  end
end
