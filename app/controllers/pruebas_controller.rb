class PruebasController < ApplicationController
  # GET /pruebas
  # GET /pruebas.xml
  include ApplicationHelper
  # GET /pruebas/1
  # GET /pruebas/1.xml
  def show
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      if ((!session["usuario"].nil?) && (session["usuario"].administrador) && (params["id"]))
          @prueba = Prueba.find(params["id"])
          @alternativas = Alternativa.find_by_sql("select * from alternativas, rasgos where rasgos.prueba_id = "+@prueba.id.to_s)
          @preguntas = Pregunta.find(:all, :include => @alternativas , :conditions => "prueba_id = "+ @prueba.id.to_s)
          session[:time] = Time.now
          respond_to do |format|
            format.html # show.html.erb
            format.xml  { render :xml => @prueba }
          end
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /pruebas/new
  # GET /pruebas/new.xml
  def new
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      session[:time] = Time.now
      prueba_data = find_prueba_preguntas
      if (session[:origen].nil?)
          session[:prueba_preguntas] = nil
      else
          if (prueba_data.modificacion == false)
              if ((session[:origen] == "new_add_pregunta") || (session[:origen] == "new_upd_alternativa") || (session[:origen] = "new_prueba_save") || (session[:origen] == "new_eliminar") || session[:origen] == "new_envio_incompleto")
                  session[:origen] = nil
              else
                  session[:prueba_preguntas] = nil
                  session[:origen] = nil
              end
          else
              session[:prueba_preguntas] = nil
              session[:origen] = nil
          end
      end

      if ((session["usuario"]) && (session["usuario"].administrador))
        lista = find_prueba_preguntas
        @prueba = lista.get_prueba
        @preguntas = lista.preguntas #lista de preguntaItems
        @rasgos = lista.rasgos #lista de rasgoItems

        respond_to do |format|
          format.html # new.html.erb
          format.xml  { render :xml => @prueba }
        end
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /pruebas/1/edit
  def edit
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      prueba_data = find_prueba_preguntas
      session[:time] = Time.now
      if ((!session[:origen]) || (prueba_data.modificacion == false))
          session[:prueba_preguntas] = nil
          prueba_data = find_prueba_preguntas

          #Carga de datos del prueba
          prueba_basico = Prueba.find(params[:id])
          prueba_data.set_prueba(prueba_basico)
          rasgo_l = Rasgo.find_by_prueba_id_and_nombre(prueba_basico.id, "Lógico")
          rasgo_f = Rasgo.find_by_prueba_id_and_nombre(prueba_basico.id, "Formal")
          rasgo_e = Rasgo.find_by_prueba_id_and_nombre(prueba_basico.id, "Emotivo")
          rasgo_i = Rasgo.find_by_prueba_id_and_nombre(prueba_basico.id, "Intuitivo")
          prueba_data.modo_editar(rasgo_l, rasgo_f, rasgo_e, rasgo_i)
          # Ahora tocaría cargar las preguntas y alternativas
          preguntas = Pregunta.find(:all, :conditions => "prueba_id = "+prueba_basico.id.to_s, :include => :alternativas )

          preguntas.each do |pregunta|
              #Estoy considerando que guarda la pregunta y alternativas "add_pregunta_antigua"
              prueba_data.add_pregunta_antigua(pregunta)
          end

      elsif ((session[:origen] == "edit_add_pregunta") || (session[:origen] == "edit_upd_alternativa") || (session[:origen] = "edit_prueba_save") || (session[:origen] == "edit_eliminar") || (session[:origen] == "edit_envio_incompleto"))
          session[:origen] = nil
          prueba_basico = Prueba.find(params[:id])
          rasgo_l = Rasgo.find_by_prueba_id_and_nombre(prueba_basico.id, "Lógico")
          rasgo_f = Rasgo.find_by_prueba_id_and_nombre(prueba_basico.id, "Formal")
          rasgo_e = Rasgo.find_by_prueba_id_and_nombre(prueba_basico.id, "Emotivo")
          rasgo_i = Rasgo.find_by_prueba_id_and_nombre(prueba_basico.id, "Intuitivo")
      end

      @prueba = prueba_data.get_prueba
      @preguntas = prueba_data.preguntas #lista de preguntaItems
      @rasgos = prueba_data.rasgos #lista de rasgoItems


      @rasgos_AR = []
      @rasgos_AR << rasgo_l
      @rasgos_AR << rasgo_f
      @rasgos_AR << rasgo_e
      @rasgos_AR << rasgo_i
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
    #redirect_to edit_prueba_path(@prueba)
  end

  # POST /pruebas
  # POST /pruebas.xml
  def create
    session[:time] = Time.now
    prueba_data = session[:prueba_preguntas]
    @prueba = Prueba.new(params[:prueba])
    prueba_data.set_prueba(@prueba)
    session[:origen] = "new_prueba_save"
    redirect_to new_prueba_path
  end

  def update_basics
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      session[:time] = Time.now
      prueba_data = session[:prueba_preguntas]
      @prueba = prueba_data.get_prueba
      auxiliar = Prueba.new(params[:prueba])
      @prueba.nombre = auxiliar.nombre
      @prueba.autor = auxiliar.autor
      @prueba.descripcion = auxiliar.descripcion
      @prueba.instrucciones = auxiliar.instrucciones
      prueba_data.set_prueba(@prueba)
      session[:origen] = "edit_prueba_save"
      redirect_to :controller => :pruebas, :action => :edit, :id => @prueba.id
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # PUT /pruebas/1
  # PUT /pruebas/1.xml
  def update
    @prueba = Prueba.find(params[:id])
    session[:time] = Time.now
    respond_to do |format|
      if @prueba.update_attributes(params[:prueba])
        flash[:notice] = 'El test fue modificado correctamente.'
        format.html { redirect_to(@prueba) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @prueba.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pruebas/1
  # DELETE /pruebas/1.xml
  def destroy
    @prueba = Prueba.find(params[:id])
    preguntas = Pregunta.find(:all, :include => :alternativas , :conditions => "prueba_id = "+ @prueba.id.to_s)
    evaluacion = Evaluacion.find(:all, :include => :respuestas , :conditions => "prueba_id = "+ @prueba.id.to_s)
    rasgos = Rasgo.find_all_by_prueba_id(@prueba.id)
    evaluacion.each do |item_e|
      item_e.respuestas.each do |item_r|
        item_r.destroy
      end
      item_e.destroy
    end
    rasgos.each do |item_g|
      item_g.destroy
    end
    preguntas.each do |item_p|
      item_p.alternativas.each do |item_a|
        item_a.destroy
      end
      item_p.destroy
    end
    @prueba.destroy

    respond_to do |format|
      format.html { redirect_to(:controller => :main, :action => :tablero) }
      format.xml  { head :ok }
    end
  end

  def orquestar_create
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      prueba_data = session[:prueba_preguntas]
      session[:time] = Time.now
      # Validación de datos
      error = false
      error_index = -99 #no errors

      lista_malas = []
      basico_malas = [0,0]

      elementos_rasgo = [] #ids temporales de rasgo
      rasgos_prueba = prueba_data.rasgos
      rasgos_prueba.each do |rasgo_prueba|
        elementos_rasgo << rasgo_prueba.identificador_rasgo
      end

      prueba_prueba = prueba_data.get_prueba
      if ((!prueba_prueba.nombre) || (prueba_prueba.nombre == ''))
        error = true
        error_index = -1
      end
      if ((!prueba_prueba.descripcion) || (prueba_prueba.descripcion == ''))
        error = true
        error_index = -1
      end
      if ((!prueba_prueba.instrucciones) || (prueba_prueba.instrucciones == ''))
        error = true
        error_index = -1
      end
      if ((!prueba_prueba.autor) || (prueba_prueba.autor == ''))
        error = true
        error_index = -1
      end

      if (error_index == -1)
        basico_malas[0] = 1
      end

      if (prueba_data.preguntas.length == 0)
        error = true
        error_index = -2 # cero preguntas
        basico_malas[1] = 1
      end

      bandera_rasgo = []
      prueba_data.preguntas.each do |pregunta_prueba|
        #break if error
        local = false #inicializo un flag por pregunta ya que error es grupal (todas las preguntas)
        bandera_rasgo = []
        4.times do
          bandera_rasgo << 0
        end
        pregunta_prueba.alternativas.each do |alternativa|
          if ((!alternativa.alternativa.texto) || (alternativa.alternativa.texto == ''))
            error = true
            local = true
            error_index = pregunta_prueba.identificador_pregunta
          end
          if alternativa.alternativa.rasgo_id
            arrayItem = elementos_rasgo.index(alternativa.alternativa.rasgo_id)
            if arrayItem
              bandera_rasgo[arrayItem] = 1 # si encuentra el rasgo
            else
              error = true
              local = true
              error_index = pregunta_prueba.identificador_pregunta
            end
          else
            error = true
            local = true
            error_index = pregunta_prueba.identificador_pregunta
          end
        end
        bandera_rasgo.each do |pre|
          if pre == 0
            error = true
            local = true
            error_index = pregunta_prueba.identificador_pregunta
          end
        end
        if local
          lista_malas << pregunta_prueba.identificador_pregunta
        end
      end
      # Fin validación de datos

      if not error
        @prueba = prueba_data.get_prueba
        if (prueba_data.rasgos.length == 4)
          @prueba.version = 1
          @prueba.publicar = true
          @prueba.invalidar = false
          @prueba.numero_preguntas = prueba_data.preguntas.length
          if @prueba.save
            # Guardando Rasgos
            prueba_data.rasgos.each do |rasgoItem|
              rasgoItem.rasgo.prueba_id = @prueba.id
              hijo = rasgoItem.rasgo
              hijo.save
            end
            # Guardando preguntas
            indice = 1

            prueba_data.preguntas.each do |preguntaItem|
              preguntaItem.pregunta.prueba_id = @prueba.id
              preguntaItem.pregunta.orden = indice
              indice = indice + 1
              preguntaItem.pregunta.invalidar = false
              if preguntaItem.pregunta.save
                # Guardando Alternativas
                preguntaItem.alternativas.each do |alternativaItem|
                  alternativaItem.alternativa.pregunta_id = preguntaItem.pregunta.id
                  current_rasgo = prueba_data.rasgos.find {|rasgoItem| rasgoItem.identificador_rasgo == alternativaItem.alternativa.rasgo_id}
                  alternativaItem.alternativa.rasgo_id = current_rasgo.rasgo.id
                  alternativaItem.alternativa.save
                end
              end
            end
          end
        end

        session[:prueba_preguntas] = nil
        flash[:notice2] = nil
        flash[:lista_negra] = nil
        flash[:basico_negra] = nil
        redirect_to :controller => :main, :action => :tablero
      else
        # mensaje de error
        session[:origen] = "new_envio_incompleto"
        flash[:notice2] = error_index.to_s
        flash[:lista_negra] = lista_malas
        flash[:basico_negra] = basico_malas
        redirect_to :controller => :pruebas, :action => :new
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  public
  def orquestar_update
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      prueba_data = session[:prueba_preguntas]
      session[:time] = Time.now
  # region Validaciones
      error = false
      error_index = -99 #no errors

      lista_malas = []
      basico_malas = [0,0]

      elementos_rasgo = [] #ids temporales de rasgo
      rasgos_prueba = prueba_data.rasgos
      rasgos_prueba.each do |rasgo_prueba|
        elementos_rasgo << rasgo_prueba.identificador_rasgo
      end

      prueba_prueba = prueba_data.get_prueba
      if ((!prueba_prueba.nombre) || (prueba_prueba.nombre == ''))
        error = true
        error_index = -1
      end
      if ((!prueba_prueba.descripcion) || (prueba_prueba.descripcion == ''))
        error = true
        error_index = -1
      end
      if ((!prueba_prueba.instrucciones) || (prueba_prueba.instrucciones == ''))
        error = true
        error_index = -1
      end
      if ((!prueba_prueba.autor) || (prueba_prueba.autor == ''))
        error = true
        error_index = -1
      end

      if (error_index == -1)
        basico_malas[0] = 1
      end

      if (prueba_data.numero_preguntas?)
        error = true
        error_index = -2 # cero preguntas
        basico_malas[1] = 1
      end

      bandera_rasgo = []
      prueba_data.preguntas.each do |pregunta_prueba|
        #break if error
        local = false
        bandera_rasgo = []
        4.times do
          bandera_rasgo << 0
        end
        pregunta_prueba.alternativas.each do |alternativa|
          if ((!alternativa.alternativa.texto) || (alternativa.alternativa.texto == ''))
            error = true
            local = true
            error_index = pregunta_prueba.identificador_pregunta
          end
          if alternativa.alternativa.rasgo_id
            arrayItem = elementos_rasgo.index(alternativa.alternativa.rasgo_id)
            if arrayItem
              bandera_rasgo[arrayItem] = 1 # si encuentra el rasgo
            else
              error = true
              local = true
              error_index = pregunta_prueba.identificador_pregunta
            end
          else
            error = true
            local = true
            error_index = pregunta_prueba.identificador_pregunta
          end
        end
        suma = 0
        bandera_rasgo.each do |pre|
          if pre == 0
            error = true
            local = true
            error_index = pregunta_prueba.identificador_pregunta
          end
        end
        if local
          lista_malas << pregunta_prueba.identificador_pregunta
        end
      end

  # endregion Validaciones

      # Fin: Validacion de los datos


      # Ahora a ver que generará el "Modificar prueba"
      if prueba_data.nueva_version?
        #Genero una nueva version del prueba#
        ###################################

        if not error



            prueba_anterior = prueba_data.get_prueba
            @prueba = Prueba.new
            @prueba.autor = prueba_anterior.autor
            @prueba.descripcion = prueba_anterior.descripcion
            @prueba.instrucciones = prueba_anterior.instrucciones
            @prueba.nombre = prueba_anterior.nombre
            @prueba.version = prueba_anterior.version + 1
            @prueba.publicar = true
            @prueba.invalidar = false
            @prueba.numero_preguntas = prueba_data.numero_preguntas?
            if @prueba.save
                # Despublico el prueba antiguo
                prueba_anterior.update_attribute("publicar", false)

                lista_rasgos_nueva = []
                # Guardando Rasgos
                prueba_data.rasgos.each do |rasgoItem|
                    rasgo_unit = Rasgo.new
                    rasgo_unit.nombre = rasgoItem.rasgo.nombre
                    rasgo_unit.descripcion = rasgoItem.rasgo.descripcion
                    rasgo_unit.prueba_id = @prueba.id
                    rasgo_unit.save
                    lista_rasgos_nueva << {:identificador => rasgoItem.identificador_rasgo, :objeto => rasgo_unit}
                end
                # Guardando preguntas
                indice = 1

                prueba_data.preguntas.each do |preguntaItem|
                    if (preguntaItem.eliminar_luego == false)
                        pregunta_unit = Pregunta.new
                        pregunta_unit.texto = preguntaItem.pregunta.texto
                        pregunta_unit.prueba_id = @prueba.id
                        pregunta_unit.orden = indice
                        pregunta_unit.invalidar = false
                        indice = indice + 1

                        if pregunta_unit.save
                            # Guardando Alternativas
                            preguntaItem.alternativas.each do |alternativaItem|
                                alternativa_unit = Alternativa.new
                                alternativa_unit.pregunta_id = pregunta_unit.id
                                alternativa_unit.texto = alternativaItem.alternativa.texto
                                current_rasgo_hash = lista_rasgos_nueva.find {|hash_item| hash_item[:identificador] == alternativaItem.alternativa.rasgo_id}
                                alternativa_unit.rasgo_id = current_rasgo_hash[:objeto].id
                                alternativa_unit.save
                            end
                        end
                    end
                end
            end

            session[:prueba_preguntas] = nil
            flash[:notice3] = nil
            flash[:lista_negra] = nil
            flash[:basico_negra] = nil
            redirect_to :controller => :main, :action => :tablero

        else # mensaje de error

            session[:origen] = "edit_envio_incompleto"
            flash[:notice3] = error_index.to_s
            flash[:lista_negra] = lista_malas
            flash[:basico_negra] = basico_malas
            redirect_to :controller => :pruebas, :action => :edit, :id => prueba_data.get_prueba.id
        end

      else #nueva_version == false

        #Actualizo la version actual del prueba#
        ######################################
        if not error
            @prueba = prueba_data.get_prueba
            if (prueba_data.rasgos.length == 4)
              @prueba.version = @prueba.version #la version se mantiene
              @prueba.publicar = true
              @prueba.invalidar = false
              @prueba.numero_preguntas = prueba_data.preguntas.length
              if @prueba.save
                # Guardando Rasgos
                  # Los rasgos ya fueron guardados en la primera creacion del prueba
                # Guardando preguntas
                indice = 1

                prueba_data.preguntas.each do |preguntaItem|
                  preguntaItem.pregunta.prueba_id = @prueba.id
                  preguntaItem.pregunta.orden = indice
                  indice = indice + 1
                  preguntaItem.pregunta.invalidar = false
                  if preguntaItem.pregunta.save
                    # Guardando Alternativas
                    preguntaItem.alternativas.each do |alternativaItem|
                      alternativaItem.alternativa.pregunta_id = preguntaItem.pregunta.id
                      current_rasgo = prueba_data.rasgos.find {|rasgoItem| rasgoItem.identificador_rasgo == alternativaItem.alternativa.rasgo_id}
                      alternativaItem.alternativa.rasgo_id = current_rasgo.rasgo.id
                      alternativaItem.alternativa.save
                    end
                  end
                end

              end
            end

            session[:prueba_preguntas] = nil
            flash[:notice3] = nil
            flash[:lista_negra] = nil
            flash[:basico_negra] = nil
            redirect_to :controller => :main, :action => :tablero

        else # mensaje de error

            session[:origen] = "edit_envio_incompleto"
            flash[:notice3] = error_index.to_s
            flash[:lista_negra] = lista_malas
            flash[:basico_negra] = basico_malas
            redirect_to :controller => :pruebas, :action => :edit, :id => @prueba.id
        end

      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
    
  end


  def index
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @pruebas = Prueba.all
      session[:time] = Time.now
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @pruebas }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end
  

  private
  def find_prueba_preguntas
    session[:prueba_preguntas] ||= PruebaPreguntas.new
  end
end
