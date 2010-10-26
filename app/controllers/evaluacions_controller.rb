require "prawn"
require "open-uri"

class EvaluacionsController < ApplicationController
  include ApplicationHelper
  # GET /evaluacions
  # GET /evaluacions.xml
  def resultadopdf
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
      @puntaje_balanceado = session[:puntos_balanceado]
      @puntaje_inventor = session[:puntos_inventor]
      @puntaje_planificado = session[:puntos_planificado]
      @puntaje_colaborativo = session[:puntos_colaborativo]
      @puntaje_implementador = session[:puntos_implementador]
      @puntaje_ejecutivo = session[:puntos_ejecutivo]
      @puntaje_traductor = session[:puntos_traductor]

      @p1 = session[:p1]
      @p3 = session[:p3]
      @p5 = session[:p5]
      @p7 = session[:p7]

      @diagnostico = session[:diagnostico]
      @recomendacion_diagnostico = session[:recomendacion_diagnostico]
      @diagnostico_par = session[:diagnostico_par]
      @recomendacion_diagnostico_par = session[:recomendacion_diagnostico_par]

      a = session["usuario"]
      a.decrypt_nombre
      @indiv = a.nombre
      a.crypt_nombre

      @urii = URI.escape("http://chart.apis.google.com/chart?chs=500x500&chxt=y,x&chxp=0,0,10,20,30,40,50,60,70,80,90,100&chd=t:"+@p1.to_s+","+@puntaje_intuitivo.to_s+","+@p3.to_s+","+@puntaje_emotivo.to_s+","+@p5.to_s+","+@puntaje_formal.to_s+","+@p7.to_s+","+@puntaje_logico.to_s+","+@p1.to_s+"&chtt=Perfil+de+Cerebro+Multidominante&chxs=0,000000,12,1|1,000000,12,1&chxr=0,0.0,100.0&chxl=1:||Intuitivo||Emotivo||Formal||Logico&cht=r&chm=f"+@puntaje_intuitivo.to_s+",CCCC00,0,1,10|f"+@puntaje_emotivo.to_s+",FF0000,0,3,10|f"+@puntaje_formal.to_s+",006600,0,5,10|f"+@puntaje_logico.to_s+",0000FF,0,7,10|r,D8D8D880,0,0.23,0|r,D7DF0180,0,0.46,0.23|r,FF800080,0,0.77,0.46|r,DF010180,0,1,0.77&chls=2&chdl=[0-23]: Rechazo (Gris)|]23-46]: Uso (Amarillo)|]46-77]: Preferencia (Naranja)|]77-100]: Visible Preferencia (Rojo)&chco=848484&chdlp=b")
      @matriz_simple_head = ["Nombre", "Fórmula", "Descripción", "Puntaje"]
      @matriz_simple = []
      @matriz_simple << ["Estilo Lógico", "A", "Izquierdo Inferior", @puntaje_logico.to_s]
      @matriz_simple << ["Estilo Formal", "B", "Derecho Inferior", @puntaje_logico.to_s]
      @matriz_simple << ["Estilo Emotivo", "C", "Derecho Superior", @puntaje_logico.to_s]
      @matriz_simple << ["Estilo Intuitivo", "D", "Izquierdo Superior", @puntaje_logico.to_s]

      @matriz_compuesta_head = ["Nombre", "Fórmula", "Descripción", "Puntaje"]
      @matriz_compuesta = []
      @matriz_compuesta << ["Estilo Realista", "A+B", "Hemisferio Izquierdo", @puntaje_realista.to_s]
      @matriz_compuesta << ["Estilo Idealista", "C+D", "Hemisferio Derecho", @puntaje_idealista.to_s]
      @matriz_compuesta << ["Estilo Cognitivo", "A+D", "Cerebral", @puntaje_cognitivo.to_s]
      @matriz_compuesta << ["Estilo Instintivo", "B+C", "Límbico", @puntaje_instintivo.to_s]
      @matriz_compuesta << ["Estilo Balanceado", "A+C", "Cerebral/Límbico", @puntaje_balanceado.to_s]
      @matriz_compuesta << ["Estilo Inventor", "B+D", "Cerebral/Límbico", @puntaje_inventor.to_s]
      @matriz_compuesta << ["Estilo Planificado", "A+B+D", "Cerebral/Límbico", @puntaje_planificado.to_s]
      @matriz_compuesta << ["Estilo Colaborativo", "A+C+D", "Cerebral/Límbico", @puntaje_colaborativo.to_s]
      @matriz_compuesta << ["Estilo Implementador", "B+C+D", "Cerebral/Límbico", @puntaje_implementador.to_s]
      @matriz_compuesta << ["Estilo Ejecutivo", "A+B+C", "Cerebral/Límbico", @puntaje_ejecutivo.to_s]


      prawnto :prawn => {
              :page_size => 'A4',
              :left_margin=>30,
              :right_margin=>30,
              :top_margin=>25,
              :bottom_margin=>25 }
      prawnto :inline => false

      respond_to do |format|
        format.pdf
      end

    end
  end

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
      @puntaje_balanceado = session[:puntos_balanceado]
      @puntaje_inventor = session[:puntos_inventor]
      @puntaje_planificado = session[:puntos_planificado]
      @puntaje_colaborativo = session[:puntos_colaborativo]
      @puntaje_implementador = session[:puntos_implementador]
      @puntaje_ejecutivo = session[:puntos_ejecutivo]
      @puntaje_traductor = session[:puntos_traductor]

      @diagnostico = session[:diagnostico]
      @recomendacion_diagnostico = session[:recomendacion_diagnostico]
      @diagnostico_par = session[:diagnostico_par]
      @recomendacion_diagnostico_par = session[:recomendacion_diagnostico_par]

      a = session["usuario"]
      a.decrypt_nombre
      @indiv = a.nombre
      a.crypt_nombre

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
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @evaluacion = Evaluacion.new
      @numero_prueba = params[:prueba].to_i
      @preguntas = Pregunta.find(:all, :include => "alternativas", :conditions => "prueba_id = "+ @numero_prueba.to_s)
      @prueba = Prueba.find(@numero_prueba)
      session[:time] = Time.now
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @evaluacion }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
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
      @puntaje_balanceado = @puntaje_logico + @puntaje_emotivo
      @puntaje_inventor = @puntaje_formal + @puntaje_intuitivo

      @puntaje_planificado = @puntaje_logico + @puntaje_formal + @puntaje_intuitivo
      @puntaje_colaborativo = @puntaje_logico + @puntaje_emotivo + @puntaje_intuitivo
      @puntaje_implementador = @puntaje_formal + @puntaje_emotivo + @puntaje_intuitivo
      @puntaje_ejecutivo = @puntaje_logico + @puntaje_formal + @puntaje_emotivo

      @puntaje_traductor = @puntaje_logico + @puntaje_formal + @puntaje_emotivo + @puntaje_intuitivo

      @evaluacion.update_attribute("puntaje_realista", @puntaje_realista)
      @evaluacion.update_attribute("puntaje_idealista", @puntaje_idealista)
      @evaluacion.update_attribute("puntaje_cognitivo", @puntaje_cognitivo)
      @evaluacion.update_attribute("puntaje_instintivo", @puntaje_instintivo)
      @evaluacion.update_attribute("puntaje_balanceado", @puntaje_balanceado)
      @evaluacion.update_attribute("puntaje_inventor", @puntaje_inventor)
      @evaluacion.update_attribute("puntaje_planificado", @puntaje_planificado)
      @evaluacion.update_attribute("puntaje_colaborativo", @puntaje_colaborativo)
      @evaluacion.update_attribute("puntaje_implementador", @puntaje_implementador)
      @evaluacion.update_attribute("puntaje_ejecutivo", @puntaje_ejecutivo)
      @evaluacion.update_attribute("puntaje_traductor", @puntaje_traductor)

      # el mas alto puntaje da el diagnostico
      arreglo = [@puntaje_logico, @puntaje_formal, @puntaje_emotivo, @puntaje_intuitivo]
      arreglo_par = [@puntaje_realista, @puntaje_idealista, @puntaje_cognitivo, @puntaje_instintivo, @puntaje_balanceado, @puntaje_inventor]
      arreglo_trio = [@puntaje_planificado, @puntaje_colaborativo, @puntaje_implementador, @puntaje_ejecutivo]

      diagnostico = []
      diagnostico_par = []
      diagnostico_trio = []

      maximo_valor = arreglo.max
      maximo_valor_par = arreglo_par.max
      maximo_valor_trio = arreglo_trio.max


      i=0
      while (i<4)
        #if (arreglo[i]==maximo_valor)
        if (arreglo[i]>=(maximo_valor-1))
          diagnostico << 1
        else
          diagnostico << 0
        end
        i = i + 1
      end

      ipar=0
      while (ipar<6)
        #if (arreglo_par[ipar]==maximo_valor_par)
        if (arreglo_par[ipar]>=(maximo_valor_par-1))
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

      # Hasta aqui el diagnostico simple
      # Ahora debo modificar el diagnostico par cuando hay empates y agregar los cruzados
      
      @diagnostico_par = ""

      if ((diagnostico_par[0] + diagnostico_par[1] + diagnostico_par[2] + diagnostico_par[3] + diagnostico_par[4] + diagnostico_par[5]) == 1)
          if (diagnostico_par[0] == 1)
            @diagnostico_par = "Realista"
          end
          if (diagnostico_par[1] == 1)
              @diagnostico_par = "Idealista"
          end
          if (diagnostico_par[2] == 1)
              @diagnostico_par = "Cognitivo"
          end
          if (diagnostico_par[3] == 1)
              @diagnostico_par = "Instintivo"
          end
          if (diagnostico_par[4] == 1)
              @diagnostico_par = "Balanceado"
          end
          if (diagnostico_par[5] == 1)
              @diagnostico_par = "Inventor"
          end
      else
          itrio=0
          while (itrio<4)
            #if (arreglo_par[ipar]==maximo_valor_par)
            if (arreglo_trio[itrio]>=(maximo_valor_trio-1))
              diagnostico_trio << 1
            else
              diagnostico_trio << 0
            end
            itrio = itrio + 1
          end

          if ((diagnostico_trio[0] + diagnostico_trio[1] + diagnostico_trio[2] + diagnostico_trio[3]) == 1)
              if (diagnostico_trio[0] == 1)
                @diagnostico_par = "Planificado"
              end
              if (diagnostico_trio[1] == 1)
                @diagnostico_par = "Colaborativo"
              end
              if (diagnostico_trio[2] == 1)
                @diagnostico_par = "Implementador"
              end
              if (diagnostico_trio[3] == 1)
                @diagnostico_par = "Ejecutivo"
              end
          else
              @diagnostico_par = "Traductor"
          end
      end


      # Si hay empate al siguiente nivel
      
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
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      evaluacion = Evaluacion.find(params[:evaluacion])
      @usrid = evaluacion.usuario_id
      @prueba = Prueba.find(evaluacion.prueba_id)
      session[:time] = Time.now
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
      @puntaje_balanceado = evaluacion.puntaje_balanceado
      @puntaje_inventor = evaluacion.puntaje_inventor
      @puntaje_planificado = evaluacion.puntaje_planificado
      @puntaje_colaborativo = evaluacion.puntaje_colaborativo
      @puntaje_implementador = evaluacion.puntaje_implementador
      @puntaje_ejecutivo = evaluacion.puntaje_ejecutivo
      @puntaje_traductor = evaluacion.puntaje_traductor

      session[:prueba_nombre] = @prueba.nombre
      session[:puntos_logico] = @puntaje_logico
      session[:puntos_formal] = @puntaje_formal
      session[:puntos_emotivo] = @puntaje_emotivo
      session[:puntos_intuitivo] = @puntaje_intuitivo
      session[:puntos_realista] = @puntaje_realista
      session[:puntos_idealista] = @puntaje_idealista
      session[:puntos_cognitivo] = @puntaje_cognitivo
      session[:puntos_instintivo] = @puntaje_instintivo
      session[:puntos_balanceado] = @puntaje_balanceado
      session[:puntos_inventor] = @puntaje_inventor
      session[:puntos_planificado] = @puntaje_planificado
      session[:puntos_colaborativo] = @puntaje_colaborativo
      session[:puntos_implementador] = @puntaje_implementador
      session[:puntos_ejecutivo] = @puntaje_ejecutivo
      session[:puntos_traductor] = @puntaje_traductor

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

      session[:p1] = @p1
      session[:p3] = @p3
      session[:p5] = @p5
      session[:p7] = @p7

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
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
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
    a = session['usuario']
    a.decrypt_nombre
    line_2.set_key( a.nombre, 10 )
    a.crypt_nombre
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
    text = []
    if (data == "Lógico")
      text[0] = {"nombre" => "Lógico", "texto" => "Busca evidencias y hechos que le permite explicar las causas o el origen de un evento específico. Contrasta la información que recoge e identifica aquello que es esencial. Valora los hechos, las medidas, los indicadores de logro. Aplica el análisis y la lógica para evaluar un problema determinado. Le gusta formular hipótesis sobre las dinámicas que ocurren entre las personas, grupos u organizaciones. Predice lo que va a pasar mañana basándose en lo que sabe hoy."}
    end
    if (data == "Formal")
      text[0] = {"nombre" => "Formal", "texto" => "Es organizado y planificado. Busca la estructura de cada situación, proceso, o contenidos y los ordena de acuerdo a ella. Le interesa conocer el relato cronológico de los hechos y los detalles de cada evento. Le gusta administrar y organizar la información de manera ordenada y que sea accesible para todos. Toma en cuenta el manejo del tiempo y busca que éste sea utilizado de manera efectiva. Recopila información paso a paso, de manera secuencial. Tiene preferencia por categorizar, clasificar, coleccionar y archivar.  Debido ala minuciosidad de su mente puede identificar hasta los errores más imperceptibles."}
    end
    if (data == "Emotivo")
      text[0] = {"nombre" => "Emotivo", "texto" => "Se interesa por las relaciones humanas y la interacción social permanente.  Busca establecer lazos duraderos y afectivos.  Escucha a los demás con atención y con espíritu de servicio. Se interesa por los proyectos que repercuten en las relaciones humanas. Aprende de las experiencias y las integra a su historia personal. Escucha y comparte ideas. En una situación crítica se involucra emocionalmente."}
    end
    if (data == "Intuitivo")
      text[0] = {"nombre" => "Intuitivo", "texto" => "Posee apertura hacia lo desconocido y hace caso a su intuición. Se interesa por lo realmente novedoso, por la creación de nuevas ideas, estructuras, estrategias, con alta capacidad de riesgo. Posee una gran necesidad de búsqueda y experimentación. Le gusta conceptualizar y simbolizar. Busca formas gráficas para expresar sus ideas o pensamientos. Utiliza su imaginación para visualizar escenarios y aprovechar de las oportunidades. Posee una visión holística. El todo es más que la suma de las partes. Posee sensibilidad artística."}
    end

    # Debo usar array de hash
    if (data == "Lógico - Formal")
      text[0] = {"nombre" => "Lógico", "texto" => "Busca evidencias y hechos que le permite explicar las causas o el origen de un evento específico. Contrasta la información que recoge e identifica aquello que es esencial. Valora los hechos, las medidas, los indicadores de logro. Aplica el análisis y la lógica para evaluar un problema determinado. Le gusta formular hipótesis sobre las dinámicas que ocurren entre las personas, grupos u organizaciones. Predice lo que va a pasar mañana basándose en lo que sabe hoy."}
      text[1] = {"nombre" => "Formal", "texto" => "Es organizado y planificado. Busca la estructura de cada situación, proceso, o contenidos y los ordena de acuerdo a ella. Le interesa conocer el relato cronológico de los hechos y los detalles de cada evento. Le gusta administrar y organizar la información de manera ordenada y que sea accesible para todos. Toma en cuenta el manejo del tiempo y busca que éste sea utilizado de manera efectiva. Recopila información paso a paso, de manera secuencial. Tiene preferencia por categorizar, clasificar, coleccionar y archivar.  Debido ala minuciosidad de su mente puede identificar hasta los errores más imperceptibles."}
    end
    if (data == "Lógico - Emotivo")
      text[0] = {"nombre" => "Lógico", "texto" => "Busca evidencias y hechos que le permite explicar las causas o el origen de un evento específico. Contrasta la información que recoge e identifica aquello que es esencial. Valora los hechos, las medidas, los indicadores de logro. Aplica el análisis y la lógica para evaluar un problema determinado. Le gusta formular hipótesis sobre las dinámicas que ocurren entre las personas, grupos u organizaciones. Predice lo que va a pasar mañana basándose en lo que sabe hoy."}
      text[1] = {"nombre" => "Emotivo", "texto" => "Se interesa por las relaciones humanas y la interacción social permanente.  Busca establecer lazos duraderos y afectivos.  Escucha a los demás con atención y con espíritu de servicio. Se interesa por los proyectos que repercuten en las relaciones humanas. Aprende de las experiencias y las integra a su historia personal. Escucha y comparte ideas. En una situación crítica se involucra emocionalmente."}
    end
    if (data == "Lógico - Intuitivo")
      text[0] = {"nombre" => "Lógico", "texto" => "Busca evidencias y hechos que le permite explicar las causas o el origen de un evento específico. Contrasta la información que recoge e identifica aquello que es esencial. Valora los hechos, las medidas, los indicadores de logro. Aplica el análisis y la lógica para evaluar un problema determinado. Le gusta formular hipótesis sobre las dinámicas que ocurren entre las personas, grupos u organizaciones. Predice lo que va a pasar mañana basándose en lo que sabe hoy."}
      text[1] = {"nombre" => "Intuitivo", "texto" => "Posee apertura hacia lo desconocido y hace caso a su intuición. Se interesa por lo realmente novedoso, por la creación de nuevas ideas, estructuras, estrategias, con alta capacidad de riesgo. Posee una gran necesidad de búsqueda y experimentación. Le gusta conceptualizar y simbolizar. Busca formas gráficas para expresar sus ideas o pensamientos. Utiliza su imaginación para visualizar escenarios y aprovechar de las oportunidades. Posee una visión holística. El todo es más que la suma de las partes. Posee sensibilidad artística."}
    end
    if (data == "Formal - Emotivo")
      text[0] = {"nombre" => "Formal", "texto" => "Es organizado y planificado. Busca la estructura de cada situación, proceso, o contenidos y los ordena de acuerdo a ella. Le interesa conocer el relato cronológico de los hechos y los detalles de cada evento. Le gusta administrar y organizar la información de manera ordenada y que sea accesible para todos. Toma en cuenta el manejo del tiempo y busca que éste sea utilizado de manera efectiva. Recopila información paso a paso, de manera secuencial. Tiene preferencia por categorizar, clasificar, coleccionar y archivar.  Debido ala minuciosidad de su mente puede identificar hasta los errores más imperceptibles."}
      text[1] = {"nombre" => "Emotivo", "texto" => "Se interesa por las relaciones humanas y la interacción social permanente.  Busca establecer lazos duraderos y afectivos.  Escucha a los demás con atención y con espíritu de servicio. Se interesa por los proyectos que repercuten en las relaciones humanas. Aprende de las experiencias y las integra a su historia personal. Escucha y comparte ideas. En una situación crítica se involucra emocionalmente."}
    end
    if (data == "Formal - Intuitivo")
      text[0] = {"nombre" => "Formal", "texto" => "Es organizado y planificado. Busca la estructura de cada situación, proceso, o contenidos y los ordena de acuerdo a ella. Le interesa conocer el relato cronológico de los hechos y los detalles de cada evento. Le gusta administrar y organizar la información de manera ordenada y que sea accesible para todos. Toma en cuenta el manejo del tiempo y busca que éste sea utilizado de manera efectiva. Recopila información paso a paso, de manera secuencial. Tiene preferencia por categorizar, clasificar, coleccionar y archivar.  Debido ala minuciosidad de su mente puede identificar hasta los errores más imperceptibles."}
      text[1] = {"nombre" => "Intuitivo", "texto" => "Posee apertura hacia lo desconocido y hace caso a su intuición. Se interesa por lo realmente novedoso, por la creación de nuevas ideas, estructuras, estrategias, con alta capacidad de riesgo. Posee una gran necesidad de búsqueda y experimentación. Le gusta conceptualizar y simbolizar. Busca formas gráficas para expresar sus ideas o pensamientos. Utiliza su imaginación para visualizar escenarios y aprovechar de las oportunidades. Posee una visión holística. El todo es más que la suma de las partes. Posee sensibilidad artística."}
    end
    if (data == "Emotivo - Intuitivo")
      text[0] = {"nombre" => "Emotivo", "texto" => "Se interesa por las relaciones humanas y la interacción social permanente.  Busca establecer lazos duraderos y afectivos.  Escucha a los demás con atención y con espíritu de servicio. Se interesa por los proyectos que repercuten en las relaciones humanas. Aprende de las experiencias y las integra a su historia personal. Escucha y comparte ideas. En una situación crítica se involucra emocionalmente."}
      text[1] = {"nombre" => "Intuitivo", "texto" => "Posee apertura hacia lo desconocido y hace caso a su intuición. Se interesa por lo realmente novedoso, por la creación de nuevas ideas, estructuras, estrategias, con alta capacidad de riesgo. Posee una gran necesidad de búsqueda y experimentación. Le gusta conceptualizar y simbolizar. Busca formas gráficas para expresar sus ideas o pensamientos. Utiliza su imaginación para visualizar escenarios y aprovechar de las oportunidades. Posee una visión holística. El todo es más que la suma de las partes. Posee sensibilidad artística."}
    end
    if (data == "Lógico – Formal - Emotivo")
      text[0] = {"nombre" => "Lógico", "texto" => "Busca evidencias y hechos que le permite explicar las causas o el origen de un evento específico. Contrasta la información que recoge e identifica aquello que es esencial. Valora los hechos, las medidas, los indicadores de logro. Aplica el análisis y la lógica para evaluar un problema determinado. Le gusta formular hipótesis sobre las dinámicas que ocurren entre las personas, grupos u organizaciones. Predice lo que va a pasar mañana basándose en lo que sabe hoy."}
      text[1] = {"nombre" => "Formal", "texto" => "Es organizado y planificado. Busca la estructura de cada situación, proceso, o contenidos y los ordena de acuerdo a ella. Le interesa conocer el relato cronológico de los hechos y los detalles de cada evento. Le gusta administrar y organizar la información de manera ordenada y que sea accesible para todos. Toma en cuenta el manejo del tiempo y busca que éste sea utilizado de manera efectiva. Recopila información paso a paso, de manera secuencial. Tiene preferencia por categorizar, clasificar, coleccionar y archivar.  Debido ala minuciosidad de su mente puede identificar hasta los errores más imperceptibles."}
      text[2] = {"nombre" => "Emotivo", "texto" => "Se interesa por las relaciones humanas y la interacción social permanente.  Busca establecer lazos duraderos y afectivos.  Escucha a los demás con atención y con espíritu de servicio. Se interesa por los proyectos que repercuten en las relaciones humanas. Aprende de las experiencias y las integra a su historia personal. Escucha y comparte ideas. En una situación crítica se involucra emocionalmente."}
    end
    if (data == "Lógico – Formal - Intuitivo")
      text[0] = {"nombre" => "Lógico", "texto" => "Busca evidencias y hechos que le permite explicar las causas o el origen de un evento específico. Contrasta la información que recoge e identifica aquello que es esencial. Valora los hechos, las medidas, los indicadores de logro. Aplica el análisis y la lógica para evaluar un problema determinado. Le gusta formular hipótesis sobre las dinámicas que ocurren entre las personas, grupos u organizaciones. Predice lo que va a pasar mañana basándose en lo que sabe hoy."}
      text[1] = {"nombre" => "Formal", "texto" => "Es organizado y planificado. Busca la estructura de cada situación, proceso, o contenidos y los ordena de acuerdo a ella. Le interesa conocer el relato cronológico de los hechos y los detalles de cada evento. Le gusta administrar y organizar la información de manera ordenada y que sea accesible para todos. Toma en cuenta el manejo del tiempo y busca que éste sea utilizado de manera efectiva. Recopila información paso a paso, de manera secuencial. Tiene preferencia por categorizar, clasificar, coleccionar y archivar.  Debido ala minuciosidad de su mente puede identificar hasta los errores más imperceptibles."}
      text[2] = {"nombre" => "Intuitivo", "texto" => "Posee apertura hacia lo desconocido y hace caso a su intuición. Se interesa por lo realmente novedoso, por la creación de nuevas ideas, estructuras, estrategias, con alta capacidad de riesgo. Posee una gran necesidad de búsqueda y experimentación. Le gusta conceptualizar y simbolizar. Busca formas gráficas para expresar sus ideas o pensamientos. Utiliza su imaginación para visualizar escenarios y aprovechar de las oportunidades. Posee una visión holística. El todo es más que la suma de las partes. Posee sensibilidad artística."}
    end
    if (data == "Lógico - Emotivo - Intuitivo")
      text[0] = {"nombre" => "Lógico", "texto" => "Busca evidencias y hechos que le permite explicar las causas o el origen de un evento específico. Contrasta la información que recoge e identifica aquello que es esencial. Valora los hechos, las medidas, los indicadores de logro. Aplica el análisis y la lógica para evaluar un problema determinado. Le gusta formular hipótesis sobre las dinámicas que ocurren entre las personas, grupos u organizaciones. Predice lo que va a pasar mañana basándose en lo que sabe hoy."}
      text[1] = {"nombre" => "Emotivo", "texto" => "Se interesa por las relaciones humanas y la interacción social permanente.  Busca establecer lazos duraderos y afectivos.  Escucha a los demás con atención y con espíritu de servicio. Se interesa por los proyectos que repercuten en las relaciones humanas. Aprende de las experiencias y las integra a su historia personal. Escucha y comparte ideas. En una situación crítica se involucra emocionalmente."}
      text[2] = {"nombre" => "Intuitivo", "texto" => "Posee apertura hacia lo desconocido y hace caso a su intuición. Se interesa por lo realmente novedoso, por la creación de nuevas ideas, estructuras, estrategias, con alta capacidad de riesgo. Posee una gran necesidad de búsqueda y experimentación. Le gusta conceptualizar y simbolizar. Busca formas gráficas para expresar sus ideas o pensamientos. Utiliza su imaginación para visualizar escenarios y aprovechar de las oportunidades. Posee una visión holística. El todo es más que la suma de las partes. Posee sensibilidad artística."}
    end
    if (data == "Formal - Emotivo - Intuitivo")
      text[0] = {"nombre" => "Formal", "texto" => "Es organizado y planificado. Busca la estructura de cada situación, proceso, o contenidos y los ordena de acuerdo a ella. Le interesa conocer el relato cronológico de los hechos y los detalles de cada evento. Le gusta administrar y organizar la información de manera ordenada y que sea accesible para todos. Toma en cuenta el manejo del tiempo y busca que éste sea utilizado de manera efectiva. Recopila información paso a paso, de manera secuencial. Tiene preferencia por categorizar, clasificar, coleccionar y archivar.  Debido ala minuciosidad de su mente puede identificar hasta los errores más imperceptibles."}
      text[1] = {"nombre" => "Emotivo", "texto" => "Se interesa por las relaciones humanas y la interacción social permanente.  Busca establecer lazos duraderos y afectivos.  Escucha a los demás con atención y con espíritu de servicio. Se interesa por los proyectos que repercuten en las relaciones humanas. Aprende de las experiencias y las integra a su historia personal. Escucha y comparte ideas. En una situación crítica se involucra emocionalmente."}
      text[2] = {"nombre" => "Intuitivo", "texto" => "Posee apertura hacia lo desconocido y hace caso a su intuición. Se interesa por lo realmente novedoso, por la creación de nuevas ideas, estructuras, estrategias, con alta capacidad de riesgo. Posee una gran necesidad de búsqueda y experimentación. Le gusta conceptualizar y simbolizar. Busca formas gráficas para expresar sus ideas o pensamientos. Utiliza su imaginación para visualizar escenarios y aprovechar de las oportunidades. Posee una visión holística. El todo es más que la suma de las partes. Posee sensibilidad artística."}
    end
    if (data == "Lógico - Formal - Emotivo - Intuitivo")
      text[0] = {"nombre" => "Lógico", "texto" => "Busca evidencias y hechos que le permite explicar las causas o el origen de un evento específico. Contrasta la información que recoge e identifica aquello que es esencial. Valora los hechos, las medidas, los indicadores de logro. Aplica el análisis y la lógica para evaluar un problema determinado. Le gusta formular hipótesis sobre las dinámicas que ocurren entre las personas, grupos u organizaciones. Predice lo que va a pasar mañana basándose en lo que sabe hoy."}
      text[1] = {"nombre" => "Formal", "texto" => "Es organizado y planificado. Busca la estructura de cada situación, proceso, o contenidos y los ordena de acuerdo a ella. Le interesa conocer el relato cronológico de los hechos y los detalles de cada evento. Le gusta administrar y organizar la información de manera ordenada y que sea accesible para todos. Toma en cuenta el manejo del tiempo y busca que éste sea utilizado de manera efectiva. Recopila información paso a paso, de manera secuencial. Tiene preferencia por categorizar, clasificar, coleccionar y archivar.  Debido ala minuciosidad de su mente puede identificar hasta los errores más imperceptibles."}
      text[2] = {"nombre" => "Emotivo", "texto" => "Se interesa por las relaciones humanas y la interacción social permanente.  Busca establecer lazos duraderos y afectivos.  Escucha a los demás con atención y con espíritu de servicio. Se interesa por los proyectos que repercuten en las relaciones humanas. Aprende de las experiencias y las integra a su historia personal. Escucha y comparte ideas. En una situación crítica se involucra emocionalmente."}
      text[3] = {"nombre" => "Intuitivo", "texto" => "Posee apertura hacia lo desconocido y hace caso a su intuición. Se interesa por lo realmente novedoso, por la creación de nuevas ideas, estructuras, estrategias, con alta capacidad de riesgo. Posee una gran necesidad de búsqueda y experimentación. Le gusta conceptualizar y simbolizar. Busca formas gráficas para expresar sus ideas o pensamientos. Utiliza su imaginación para visualizar escenarios y aprovechar de las oportunidades. Posee una visión holística. El todo es más que la suma de las partes. Posee sensibilidad artística."}
    end

    text
  end

  def find_recomendacion_par(data)
    if (data == "Realista")
      text = "Busca la lógica de las decisiones, para lo cual necesita contar con evidencias, hechos y detalles que confirmen lo esperado. Dedica tiempo a precisar y definir procesos para lograr resultados. Aprecia el conocimiento técnico, los indicadores y la posibilidad de medir y evaluar. Plantea metas claras y espera resultados concretos.  Aprecia los reportes que describan la marcha de los hechos y los resultados de la gestión. Aprecia los fundamentos y las teorías que están detrás de las decisiones. Posee fluidez verbal. Busca el dominio del método y contar con algún tipo de conocimiento técnico."
    end
    if (data == "Balanceado")
      text = "Busca el balance entre la emoción y la razón. Recoge evidencias tanto del proceso como del resultado. La decisión es correcta porque responde a sus sentimientos y a una lógica determinada.  Toma tiempo para tomar decisiones por lo que quiere ser justo. No se conforma con plantear netas desafiantes, sino que busca que las personas se involucren y comprometan con ellas."
    end
    if (data == "Cognitivo")
      text = "Es un intelectual que gusta de conceptualizar y comprender el funcionamiento de las organizaciones y sistemas. Construye explicaciones sobre lo que ocurre, lanza hipótesis y explora las causas. Investiga y contrasta modelos. Busca oportunidades de desarrollo. Construye una visión y plantea metas claras que inspiren a las personas involucradas. Se inspira a través de los hechos y de las personas. Contextualiza y analiza el impacto de un hecho en el TODO, en el SISTEMA."
    end
    if (data == "Instintivo")
      text = "Destaca por implementar y ejecutar los proyectos cuando tiene las metas claras. Cumple con los plazos. Identifica todos los procesos necesarios para desarrollar cada meta. Aprecia el trabajo en equipo cuando los roles están claramente definidos. Le gusta trabajar con personas organizadas que gustan sostener las relaciones humanas. Le da gran importancia a las formas, a las costumbres y a los rituales. Se adapta a diferentes escenarios siempre y cuando de por medio haya acción y emoción."
    end
    if (data == "Inventor")
      text = "Realiza propuestas innovadoras y las define con el máximo de detalle y precisión. Organiza actividades que convergen con la idea matriz. Se concentra en lo que hace de modo que no se detiene hasta finalizarlo. Le gusta hacer un seguimiento de todas las tareas durante el proceso de ejecución. El control de la calidad es parte de sus prioridades. Se concentra en lo que hace de modo que no se detiene hasta finalizar las tareas programadas. Posee un espíritu perfeccionista. La forma le preocupa tanto como el fondo."
    end
    if (data == "Idealista")
      text = "Es idealista en la forma de configurar el mundo. Cuando descubre una oportunidad de desarrollo la comparte y la socializa. A medida que la comunica va completando su idea con lo que recoge y escucha de los demás. Le gusta aprender de las relaciones interpersonales. Es intuitivo y metafórico en cada una de sus explicaciones y elaboraciones sobre los hechos. Puede trabajar en equipo y construir las propuestas en forma colaborativa. Es informal y confía en la iniciativa del equipo para completar las tareas y conseguir los resultados. Posee sensibilidad artística. Busca espacios para establecer una comunicación directa."
    end
    if (data == "Ejecutivo")
      text = "Disfruta aterrizando las propuestas e ideas. Aplica de manera muy práctica los modelos o enfoques teóricos. Invierte mucho tiempo en sistematizar lo que hay. Analiza los incidentes hasta encontrar las causas que los han originado. Motiva al equipo a ejecutar todas las tareas y llegar a buen término. No se detiene ante los obstáculos, por el contrario es proactivo y busca soluciones alternativas. Se anticipa y en caso aparezcan situaciones inesperadas puede crear planes de contingencia."
    end
    if (data == "Planificado")
      text = "Es capaz de diseñar un programa o una propuesta a partir de una visión inspiradora.  Puede precisar las metas, indicadores y procesos definidos. Pero le cuesta socializar la propuesta. Posee dificultades para establecer la red social. Solo el 30% de la población se encuentra en este segmento."
    end
    if (data == "Colaborativo")
      text = "Es capaz de motivar a otros para trabajar en equipo y complementar las habilidades. Cada vez que diseña una propuesta, lo hace de manera intuitiva y holística. No sólo ve el árbol sino el bosque. Una vez que crea un proyecto le gusta socializarlo y escuchar con gran apertura las críticas y sugerencias. No tiene claridad de los procedimientos a seguir pero tiene claro el norte y la dirección. Se le escapan los detalles y puede comenzar por cualquier parte. Necesita de una estructura y de un orden."
    end
    if (data == "Implementador")
      text = "Propone ideas innovadoras. No se detiene a analizar o a sustentar sus decisiones. Necesita precisar metas e indicadores de medición. Se entusiasma con las propuestas y motiva a otros a participar. Establece modelos de trabajo.  Trabaja en equipo con empatía y conciencia del proceso. Busca retroalimentar a sus compañeros de grupo y establece un cronograma detallado a seguir para mantener todo con orden y claridad."
    end
    if (data == "Traductor")
      text = "Es un traductor. Puede comunicarse con cualquiera de los estilos de pensamiento. Se adapta a los diferentes modelos y formas de percibir y de interpretar. Es flexible y ejerce su autoridad para desarrollar todo su potencial. Es empático y tiende a desarrollar todos sus talentos al máximo.  Posee la habilidad para desarrollar tanto un análisis cuantitativo como cualitativo. Es capaz de argumentar, diseñar, negociar o socializar."
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
