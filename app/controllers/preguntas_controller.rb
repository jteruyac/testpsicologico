class PreguntasController < ApplicationController
  # GET /preguntas
  # GET /preguntas.xml
  def index
    @preguntas = Pregunta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @preguntas }
    end
  end

  # GET /preguntas/1
  # GET /preguntas/1.xml
  def show
    @pregunta = Pregunta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pregunta }
    end
  end

  # GET /preguntas/new
  # GET /preguntas/new.xml
  def new
    @pregunta = Pregunta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pregunta }
    end
  end

  # GET /preguntas/1/edit
  def edit
    @pregunta = Pregunta.find(params[:id])
  end

  # POST /preguntas
  # POST /preguntas.xml
  def create
    if ((params[:pantalla]) && (params[:pantalla][:id] == "Crear"))
        pregunta = Pregunta.new(params[:pregunta])
        prueba_data = session[:prueba_preguntas]
        prueba_data.add_pregunta(pregunta)

        flash[:pregunta_creada] = 'si'
        flash[:pregunta_creada_indice] = prueba_data.indice_preguntas - 1
        session[:prueba_preguntas] = prueba_data
        session[:origen] = "new_add_pregunta"

        redirect_to new_prueba_path
    elsif ((params[:pantalla]) && (params[:pantalla][:id] == "Editar"))
        pregunta = Pregunta.new(params[:pregunta])
        prueba_data = session[:prueba_preguntas]
        prueba_data.add_pregunta(pregunta)

        flash[:pregunta_creada] = 'si'
        flash[:pregunta_creada_indice] = prueba_data.indice_preguntas - 1
        session[:prueba_preguntas] = prueba_data
        session[:origen] = "edit_add_pregunta"

        redirect_to :controller => :pruebas, :action => :edit, :id => pregunta.prueba_id
    end
  end

  # PUT /preguntas/1
  # PUT /preguntas/1.xml
  def update
    @pregunta = Pregunta.find(params[:id])

    respond_to do |format|
      if @pregunta.update_attributes(params[:pregunta])
        flash[:notice] = 'Pregunta was successfully updated.'
        format.html { redirect_to(@pregunta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pregunta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /preguntas/1
  # DELETE /preguntas/1.xml
  def destroy
#    @pregunta = Pregunta.find(params[:id])
#    @pregunta.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(preguntas_url) }
#      format.xml  { head :ok }
#    end
  end

  def eliminar

    identidad = params['id']
    prueba_data = session[:prueba_preguntas]
    prueba_data.drop_pregunta(identidad)
    session[:prueba_preguntas] = prueba_data
    session[:origen] = "new_eliminar"
    redirect_to :controller => :pruebas, :action => :new
  end


  def eliminar_edit
    # En el caso de editar el prueba solo debo marcar la pregunta

    nro_prueba = params['prueba']
    identidad = params['id']
    prueba_data = session[:prueba_preguntas]
    prueba_data.drop_pregunta_edit(identidad)
    session[:prueba_preguntas] = prueba_data
    session[:origen] = "edit_eliminar"
    redirect_to :controller => :pruebas, :action => :edit, :id => nro_prueba

  end
end
