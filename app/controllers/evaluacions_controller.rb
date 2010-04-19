class EvaluacionsController < ApplicationController
  # GET /evaluacions
  # GET /evaluacions.xml
  def resultadoxls
    if ((session[:rpt_tipo] == "resultado") && (params['clv'].to_s == session[:rpt_codigo].to_s))
      @prueba_nombre = session[:prueba_nombre]
      @puntaje_logico = session[:puntos_logico]
      @puntaje_formal = session[:puntos_formal]
      @puntaje_emotivo = session[:puntos_emotivo]
      @puntaje_intuitivo = session[:puntos_intuitivo]
      @puntaje_realista = session[:puntos_realista]
      @puntaje_idealista = session[:puntos_idealista]
      @puntaje_cognitivo = session[:puntos_cognitivo]
      @puntaje_instintivo = session[:puntos_instintivo]

      @diagnostico = session[:diagnostico]
      @recomendacion_diagnostico = session[:recomendacion_diagnostico]
      @diagnostico_par = session[:diagnostico_par]
      @recomendacion_diagnostico_par = session[:recomendacion_diagnostico_par]

      respond_to do |format|
        #format.html # index.html.erb
        format.xls
      end
    end
  end


  def index
    @evaluacions = Evaluacion.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @evaluacions }
    end
  end

  # GET /evaluacions/1
  # GET /evaluacions/1.xml
  def show
    @evaluacion = Evaluacion.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @evaluacion }
    end
  end

  # GET /evaluacions/new
  # GET /evaluacions/new.xml
  def new
    @evaluacion = Evaluacion.new
    @numero_prueba = params[:prueba].to_i
    @preguntas = Pregunta.find(:all, :include => "alternativas", :conditions => "prueba_id = "+ @numero_prueba.to_s)
    @prueba = Prueba.find(@numero_prueba)
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @evaluacion }
    end
  end

  # GET /evaluacions/1/edit
  def edit
    @evaluacion = Evaluacion.find(params[:id])
  end

  # POST /evaluacions
  # POST /evaluacions.xml
  def create
    @evaluacion = Evaluacion.new(params[:evaluacion])
    @evaluacion.fecha = Time.now
    @preguntas = Pregunta.find(:all, :include => "alternativas", :conditions => "prueba_id = "+ @evaluacion.prueba_id.to_s)
    
    @usuario = Usuario.find(@evaluacion.usuario_id)
    edad_n = (@usuario.fecha_nacimiento.to_date.year*10000)+(@usuario.fecha_nacimiento.to_date.month * 100)+(@usuario.fecha_nacimiento.to_date.day * 100)
    edad_e = (@evaluacion.fecha.to_date.year*10000)+(@evaluacion.fecha.to_date.month * 100)+(@evaluacion.fecha.to_date.day * 100)
    edad_fin = (edad_e - edad_n)/10000
    @evaluacion.edad = edad_fin

    if @usuario.institucion_id
      institucion = Institucion.find(@usuario.institucion_id)
      tags = institucion.tags.all
      esta = false
      tags.each do |tg|
        if tg.codigo == @evaluacion.tag_codigo
          esta = true
        end
      end
      if !esta
        @evaluacion.tag_codigo = nil
      end
    else
      @evaluacion.tag_codigo = nil
    end

    if @evaluacion.save
      # Salvar respuestas
      @preguntas.each do |pregunta|
        pregunta.alternativas.each do |alternativa|
          puntaje = params['pregunta'+pregunta.id.to_s]['alternativa'+alternativa.id.to_s]
          respuesta = Respuesta.new
          respuesta.evaluacion_id = @evaluacion.id
          respuesta.alternativa_id = alternativa.id
          respuesta.pregunta_id = pregunta.id
          respuesta.rasgo_id = alternativa.rasgo_id
          respuesta.puntaje = puntaje

          respuesta.save
        end
    end

      # calculador
        evaluacion_cal = Evaluacion.find(@evaluacion.id, :include => "respuestas")
        @prueba_cal = Prueba.find(evaluacion_cal.prueba_id, :include => "preguntas" )
        rasgos_cal = Rasgo.find(:all, :conditions => 'prueba_id = '+@prueba_cal.id.to_s )
        ############
        # Puntajes #
        ############
        @puntaje_logico = 0
        @puntaje_formal = 0
        @puntaje_emotivo = 0
        @puntaje_intuitivo = 0

        @prueba_cal.preguntas.each do |pregunta_cal|
          rasgos_cal.each do |rasgo_cal|
            respuesta_exacta = evaluacion_cal.respuestas.find(:first, :conditions => 'pregunta_id = '+pregunta_cal.id.to_s+' and rasgo_id = '+ rasgo_cal.id.to_s)
            if (rasgo_cal.nombre == "Lógico")
              @puntaje_logico = @puntaje_logico + respuesta_exacta.puntaje
            end
            if (rasgo_cal.nombre == "Formal")
              @puntaje_formal = @puntaje_formal + respuesta_exacta.puntaje
            end
            if (rasgo_cal.nombre == "Emotivo")
              @puntaje_emotivo = @puntaje_emotivo + respuesta_exacta.puntaje
            end
            if (rasgo_cal.nombre == "Intuitivo")
              @puntaje_intuitivo = @puntaje_intuitivo + respuesta_exacta.puntaje
            end
          end
        end

      @evaluacion.update_attribute("puntaje_logico", @puntaje_logico)
      @evaluacion.update_attribute("puntaje_formal", @puntaje_formal)
      @evaluacion.update_attribute("puntaje_emotivo", @puntaje_emotivo)
      @evaluacion.update_attribute("puntaje_intuitivo", @puntaje_intuitivo)

      @puntaje_realista = @puntaje_logico + @puntaje_formal
      @puntaje_idealista = @puntaje_emotivo + @puntaje_intuitivo
      @puntaje_cognitivo = @puntaje_logico + @puntaje_intuitivo
      @puntaje_instintivo = @puntaje_formal + @puntaje_emotivo
      @evaluacion.update_attribute("puntaje_realista", @puntaje_realista)
      @evaluacion.update_attribute("puntaje_idealista", @puntaje_idealista)
      @evaluacion.update_attribute("puntaje_cognitivo", @puntaje_cognitivo)
      @evaluacion.update_attribute("puntaje_instintivo", @puntaje_instintivo)

      # el mas alto puntaje da el diagnostico
      arreglo = [@puntaje_logico, @puntaje_formal, @puntaje_emotivo, @puntaje_intuitivo]
      arreglo_par = [@puntaje_realista, @puntaje_idealista, @puntaje_cognitivo, @puntaje_instintivo]
      diagnostico = []
      diagnostico_par = []
      maximo_valor = arreglo.max
      maximo_valor_par = arreglo_par.max

      i=0
      while (i<4)
        if (arreglo[i]==maximo_valor)
          diagnostico << 1
        else
          diagnostico << 0
        end
        i = i + 1
      end

      ipar=0
      while (ipar<4)
        if (arreglo_par[ipar]==maximo_valor_par)
          diagnostico_par << 1
        else
          diagnostico_par << 0
        end
        ipar = ipar + 1
      end

      @diagnostico = ""
      if (diagnostico[0] == 1)
        @diagnostico = "Lógico"
      end
      if (diagnostico[1] == 1)
        if (@diagnostico == "")
          @diagnostico = "Formal"
        else
          @diagnostico = @diagnostico + " - Formal"
        end
      end
      if (diagnostico[2] == 1)
        if (@diagnostico == "")
          @diagnostico = "Emotivo"
        else
          @diagnostico = @diagnostico + " - Emotivo"
        end
      end
      if (diagnostico[3] == 1)
        if (@diagnostico == "")
          @diagnostico = "Intuitivo"
        else
          @diagnostico = @diagnostico + " - Intuitivo"
        end
      end

      @evaluacion.update_attribute("tipo_dominante", @diagnostico)


      @diagnostico_par = ""
      if (diagnostico_par[0] == 1)
        @diagnostico_par = "Realista"
      end
      if (diagnostico_par[1] == 1)
        if (@diagnostico_par == "")
          @diagnostico_par = "Idealista"
        else
          @diagnostico_par = @diagnostico_par + " - Idealista"
        end
      end
      if (diagnostico_par[2] == 1)
        if (@diagnostico_par == "")
          @diagnostico_par = "Cognitivo"
        else
          @diagnostico_par = @diagnostico_par + " - Cognitivo"
        end
      end
      if (diagnostico_par[3] == 1)
        if (@diagnostico_par == "")
          @diagnostico_par = "Instintivo"
        else
          @diagnostico_par = @diagnostico_par + " - Instintivo"
        end
      end

      @evaluacion.update_attribute("par_dominante", @diagnostico_par)

      # calculador    
      redirect_to :controller => 'evaluacions', :action => 'resultado', :evaluacion => @evaluacion.id
    end
    
  end

  # PUT /evaluacions/1
  # PUT /evaluacions/1.xml
  def update
    @evaluacion = Evaluacion.find(params[:id])

    respond_to do |format|
      if @evaluacion.update_attributes(params[:evaluacion])
        flash[:notice] = 'Evaluacion was successfully updated.'
        format.html { redirect_to(@evaluacion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @evaluacion.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /evaluacions/1
  # DELETE /evaluacions/1.xml
  def destroy
    @evaluacion = Evaluacion.find(params[:id])
    @evaluacion.destroy

    respond_to do |format|
      format.html { redirect_to(evaluacions_url) }
      format.xml  { head :ok }
    end
  end

  def resultado
    evaluacion = Evaluacion.find(params[:evaluacion])
    @usrid = evaluacion.usuario_id
    @prueba = Prueba.find(evaluacion.prueba_id)
    ############
    # Puntajes #
    ############
    @puntaje_logico = evaluacion.puntaje_logico
    @puntaje_formal = evaluacion.puntaje_formal
    @puntaje_emotivo = evaluacion.puntaje_emotivo
    @puntaje_intuitivo = evaluacion.puntaje_intuitivo

    @puntaje_realista = evaluacion.puntaje_realista
    @puntaje_idealista = evaluacion.puntaje_idealista
    @puntaje_cognitivo = evaluacion.puntaje_cognitivo
    @puntaje_instintivo = evaluacion.puntaje_instintivo

    session[:prueba_nombre] = @prueba.nombre
    session[:puntos_logico] = @puntaje_logico
    session[:puntos_formal] = @puntaje_formal
    session[:puntos_emotivo] = @puntaje_emotivo
    session[:puntos_intuitivo] = @puntaje_intuitivo
    session[:puntos_realista] = @puntaje_realista
    session[:puntos_idealista] = @puntaje_idealista
    session[:puntos_cognitivo] = @puntaje_cognitivo
    session[:puntos_instintivo] = @puntaje_instintivo

    ##########

    @p1 = calcularx(@puntaje_logico, @puntaje_intuitivo)
    @p3 = calcularx(@puntaje_intuitivo, @puntaje_emotivo)
    @p5 = calcularx(@puntaje_emotivo, @puntaje_formal)
    @p7 = calcularx(@puntaje_formal, @puntaje_logico)

    ##########

    @diagnostico = evaluacion.tipo_dominante
    @diagnostico_par = evaluacion.par_dominante
    @recomendacion_diagnostico = find_recomendacion(@diagnostico)
    @recomendacion_diagnostico_par = find_recomendacion_par(@diagnostico_par)

    session[:diagnostico] = @diagnostico
    session[:recomendacion_diagnostico] = @recomendacion_diagnostico
    session[:diagnostico_par] = @diagnostico_par
    session[:recomendacion_diagnostico_par] = @recomendacion_diagnostico_par

    session[:rpt_tipo] = "resultado"
    @code = rand(4321)
    session[:rpt_codigo] = @code

    ##########
    @graph = open_flash_chart_object(600,300,"/evaluacions/graph_code_radar")
    # Despliegue:
    #@graph = open_flash_chart_object(600,300,"/TestPsicologico/evaluacions/graph_code_radar", true, "/TestPsicologico/")

  end


  def graph_code_radar

    chart = OpenFlashChart.new
    chart.set_title(Title.new('Perfil de la Dominancia Cerebral de Herrmann'))
    line_2 = LineDot.new


    arreglo = [session[:puntos_logico].to_i, session[:puntos_formal].to_i, session[:puntos_emotivo].to_i, session[:puntos_intuitivo].to_i]
    # arreglo = [34, 38, 16, 12]
    arreglo = arreglo.reverse

    p2 = arreglo[0]
    p4 = arreglo[1]
    p6 = arreglo[2]
    p8 = arreglo[3]

    p1 = calcularx(p8,p2)
    p3 = calcularx(p2,p4)
    p5 = calcularx(p4,p6)
    p7 = calcularx(p6,p8)

    line_2.set_values(Array.new([p1,p2,p3,p4,p5,p6,p7,p8]))
    line_2.set_halo_size( 0 )
    line_2.set_width( 1 )
    line_2.set_dot_size( 0 )
    line_2.set_colour( '#8000FF' )
    line_2.set_tooltip( "Puntaje<br>#val#" )
    line_2.set_key( session['usuario'].nombre, 10 )
    line_2.loop() # to close the loop
    chart.add_element( line_2 )

    r = RadarAxis.new( 60 )
    r.set_steps(5)
    r.set_colour( '#DAD5E0' )
    r.set_grid_colour( '#DAD5E0' )

    spoke_labels = RadarSpokeLabels.new(Array.new([
        '',
        'Intuitivo',
        '',
        'Emotivo',
        '',
        'Formal',
        '',
        'Lógico']))

    spoke_labels.set_colour( '#9F819F' )
    r.set_spoke_labels( spoke_labels )
    chart.set_radar_axis( r )

    tooltip = Tooltip.new(:mouse => 2)
    tooltip.set_proximity()
    chart.set_tooltip( tooltip )
    chart.set_bg_colour( '#EFFBEF' )

    render :text => chart.to_s
  end

  private
  def calcularx(a, b)
      # triangulo grande
      c = Math.hypot(a, b)
      if c != 0
          angulo_beta = Math.asin(a/c)
          pi = Math.acos(-1)
          angulo_alfa = (pi/2) - angulo_beta

          # triangulo pequeño
          x = (b*Math.sin(angulo_beta))/(Math.sin((pi/4)+angulo_alfa))

      else
          x = 0
      end
      return x
  end

  def find_recomendacion(data)
    if (data == "Lógico")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Formal")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Emotivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Intuitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Lógico - Formal")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Lógico - Emotivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Lógico - Intuitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Formal - Emotivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Formal - Intuitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Emotivo - Intuitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Lógico – Formal - Emotivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Lógico – Formal - Intuitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Lógico - Emotivo - Intuitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Formal - Emotivo - Intuitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end
    if (data == "Lógico - Formal - Emotivo - Intuitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento dominante."
    end

    text
  end

  def find_recomendacion_par(data)

    if (data == "Realista")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Idealista")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Cognitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Instintivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Realista - Idealista")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Realista - Cognitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Realista - Instintivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Idealista - Cognitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Idealista - Instintivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Cognitivo - Instintivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Realista – Idealista - Cognitivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Realista – Idealista - Instintivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Realista - Cognitivo - Instintivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Idealista - Cognitivo - Instintivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end
    if (data == "Realista - Idealista - Cognitivo - Instintivo")
      text = "En esta sección se colocará la descripción del estilo del pensamiento par dominante."
    end

    text
  end

  private
  def round_to_n_decimals(n,x)
    (n * 10**x).round.to_f / 10**x
  end

  def calcularx(a, b)
      # triangulo grande
      c = Math.hypot(a, b)
      if c != 0
          angulo_beta = Math.asin(a/c)
          pi = Math.acos(-1)
          angulo_alfa = (pi/2) - angulo_beta

          # triangulo pequeño
          x = (b*Math.sin(angulo_beta))/(Math.sin((pi/4)+angulo_alfa))

      else
          x = 0
      end
      return x
  end

end
