class ReportesController < ApplicationController
  include ApplicationHelper
  
  def dominanciaxls
    if ((session[:rpt_tipo] == "dominancia") && (params['clv'].to_s == session[:rpt_codigo].to_s))
      @prueba = session[:rpt_prueba]
      @cant_usuarios = session[:rpt_cant_usuarios]
      @filtros = session[:rpt_filtros]
      @lista_hashes = session[:rpt_lista_hashes]
      @conteo_diagnosticos = session[:conteo_diagnosticos]
      @conteo_diagnosticos_par = session[:conteo_diagnosticos_par] =

      respond_to do |format|
        #format.html # index.html.erb
        format.xls
      end
    end
  end

  def promediosxls
    if ((session[:rpt_tipo] == "promedios") && (params['clv'].to_s == session[:rpt_codigo].to_s))
      @prueba = session[:rpt_prueba]
      @cant_usuarios = session[:rpt_cant_usuarios]
      @filtros = session[:rpt_filtros]
      @totales = session[:rpt_totales]
      @lista_hashes = session[:rpt_lista_hashes]
      @conteo_diagnosticos = session[:conteo_diagnosticos]
      @conteo_diagnosticos_par = session[:conteo_diagnosticos_par]

      respond_to do |format|
        #format.html # index.html.erb
        format.xls
      end
    end
  end


  def panel
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      if ((session["usuario"])&&(session["usuario"].administrador == true))
        @pruebas = Prueba.find_all_by_publicar(true)
        @instituciones = Institucion.all
        @carreras = Carrera.all
        session[:time] = Time.now
      else
        session["usuario"] = nil
        session["HttpContextId"] = nil
        flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
        redirect_to :controller => :main, :action => :login
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  def promedio
    if ((session["usuario"])&&(session["usuario"].administrador == true))

        # Datos para la consulta de usuarios coincidentes
        valores = params[:formulario]
        @prueba = Prueba.find(valores["prueba_id"], :include => :preguntas)
        @filtros = []

        sql = "select * from usuarios "
        condiciones = ""


        if (valores["institucion_id"] != "")
          nombre_institucion = Institucion.find(valores["institucion_id"]).nombre
          @filtros << {:campo => 'Institución', :valor => nombre_institucion }
          if (condiciones == "")
            condiciones = "where institucion_id = '"+valores["institucion_id"].to_s + "'"
          else
            condiciones = condiciones + " and institucion_id = '"+valores["institucion_id"].to_s + "'"
          end
        end
        if (valores["sexo"] != "No especificar")
          @filtros << {:campo => 'Sexo', :valor => valores["sexo"].to_s }
          if (condiciones == "")
            condiciones = "where sexo = '"+valores["sexo"].to_s + "'"
          else
            condiciones = condiciones + " and sexo = '"+valores["sexo"].to_s + "'"
          end
        end
        if (valores["escuela"] != "No especificar")
          @filtros << {:campo => 'Colegio', :valor => valores["escuela"]}
          if (condiciones == "")
            condiciones = "where tipo_colegio = '"+valores["escuela"].to_s + "'"
          else
            condiciones = condiciones + " and tipo_colegio = '"+valores["escuela"].to_s + "'"
          end
        end

        # Lugar de nacimiento
        if (valores["lugar_nacimiento"] != "No especificar")
          @filtros << {:campo => 'Ubicación general', :valor => valores["lugar_nacimiento"]}
          if (condiciones == "")
            condiciones = "where ubicacion_macro = '"+valores["lugar_nacimiento"].to_s + "'"
            if (valores["ubicacion_micro"] != "No especificar")
              @filtros << {:campo => 'Ubicación específica', :valor => valores["ubicacion_micro"]}
              condiciones = condiciones + " and ubicacion_micro = '"+valores["ubicacion_micro"].to_s + "'"
            end
          else
            condiciones = condiciones + " and ubicacion_macro = '"+valores["lugar_nacimiento"].to_s + "'"
            if (valores["ubicacion_micro"] != "No especificar")
              @filtros << {:campo => 'Ubicación específica', :valor => valores["ubicacion_micro"]}
              condiciones = condiciones + " and ubicacion_micro = '"+valores["ubicacion_micro"].to_s + "'"
            end
          end
        end

        # Todo lo referente a universidad
        if (valores["consulta_universidad"] != "No especificar")
          @filtros << {:campo => 'Universidad', :valor => valores["consulta_universidad"]}
          if (condiciones == "")
            if (valores["consulta_universidad"] == "Si")
              condiciones = "where consulta_universidad = true"
            else
              condiciones = "where consulta_universidad = false"
            end
          else
            if (valores["consulta_universidad"] == "Si")
              condiciones = condiciones + " and consulta_universidad = true"
            else
              condiciones = condiciones + " and consulta_universidad = false"
            end
          end
          if (valores["consulta_universidad"] == "Si")
            if (valores["carrera_id"] != "")
                nombre_carrera = Carrera.find(valores["carrera_id"]).nombre
                @filtros << {:campo => 'Carrera', :valor => nombre_carrera }
                condiciones = condiciones + " and carrera_id = " + valores["carrera_id"].to_s
                if ((valores["carrera_id"] == "Psicología") && (valores["especialidad"] != "No especificar"))
                    @filtros << {:campo => 'Especialidad', :valor => valores["especialidad"] }
                    condiciones = condiciones + " and nombre_especialidad = " + valores["especialidad"].to_s
                end
            end
            if (valores["universidad_ingreso"] != "")
                @filtros << {:campo => 'Año de ingreso a la universidad', :valor => valores["universidad_ingreso"] }
                condiciones = condiciones + " and anio_ingreso_universidad = " + valores["universidad_ingreso"].to_s
            end
            if (valores["consulta_egresado"] != "No especificar")
                @filtros << {:campo => 'Egresado', :valor => valores["consulta_egresado"] }
                if (valores["consulta_egresado"] == "Si")
                  condiciones = condiciones + " and consulta_egresado = true"
                else
                  condiciones = condiciones + " and consulta_egresado = false"
                end
                if (valores["consulta_egresado"] == "Si") && (valores["universidad_egreso"] != "")
                  @filtros << {:campo => 'Año de egreso de la universidad', :valor => valores["universidad_egreso"] }
                  condiciones = condiciones + " and anio_egreso_universidad = " + valores["universidad_egreso"].to_s
                end
            end
          end
        end
        # Finally: No admin
        if (condiciones == "")
           condiciones = "where administrador = false"
        else
           condiciones = condiciones + " and administrador = false"
        end


        sql = sql + condiciones
        usuarios = Usuario.find_by_sql sql
        # Cierre: Datos para la consulta de usuarios coincidentes

        @lista_hashes = []
        # Condiciones para la consulta de evaluaciones
        condiciones_eval = "prueba_id = " + @prueba.id.to_s
        if (valores["edad"] != "")
          @filtros << {:campo => 'Edad', :valor => valores["edad"].to_s }
          if (condiciones_eval == "")
            condiciones_eval = "edad = " + valores["edad"].to_s
          else
            condiciones_eval = condiciones_eval + " and edad = " + valores["edad"].to_s
          end
        end
        if ((valores["institucion_id"] != "") && (valores["tag"] != ""))
          @filtros << {:campo => 'Tag', :valor => valores["tag"] }
          if (condiciones_eval == "")
           condiciones_eval = "tag_codigo = " + valores["tag"].to_s
          else
           condiciones_eval = condiciones_eval + " and tag_codigo = " + valores["tag"].to_s
          end
        end
        if (valores["consulta_fechas"]=="1")
            @filtros << {:campo => 'Fecha inicio', :valor => valores["fecha_inicio"].to_date.to_s }
            @filtros << {:campo => 'Fecha fin', :valor => valores["fecha_fin"].to_date.to_s }
            if (condiciones_eval == "")
              condiciones_eval = "fecha >= '" + valores["fecha_inicio"].to_date.to_s + "' and fecha <= '" + (valores["fecha_fin"].to_date + 1.days).to_s + "'"
            else
              condiciones_eval = condiciones_eval + " and fecha >= '" + valores["fecha_inicio"].to_date.to_s + "' and fecha <= '" + (valores["fecha_fin"].to_date + 1.days).to_s + "'"
            end
        end

        condiciones_eval
        lista_evaluaciones = []

        usuarios.each do |individuo|
          #buscar las evaluaciones para este individuo, tomo la mas vieja que este dentro de los
          #parametros de busqueda si hay coincidencias. Luego lo añado a mi lista.
            evals = individuo.evaluacions.find(:all, :conditions => condiciones_eval) #-------> añadir las condiciones
            if (evals.length != 0)
                lista_evaluaciones << evals[evals.length - 1]
            end

        end
        @cant_usuarios = lista_evaluaciones.length #cantidad de usuarios tomados


        #Orden del array L, F, E, I, LF, LE, LI, FE, FI, EI, LFE, LFI, LEI, FEI, LFEI
        @conteo_diagnosticos = Array.new(15, 0)
        @conteo_diagnosticos_par = Array.new(11, 0)

        totalL = 0
        totalF = 0
        totalE = 0
        totalI = 0
        lista_evaluaciones.each do |valores|
            totalL = totalL + valores.puntaje_logico
            totalF = totalF + valores.puntaje_formal
            totalE = totalE + valores.puntaje_emotivo
            totalI = totalI + valores.puntaje_intuitivo

            #Conteo de diagnosticos
            case valores.tipo_dominante
            when "Lógico"
              @conteo_diagnosticos[0] += 1
            when "Formal"
              @conteo_diagnosticos[1] += 1
            when "Emotivo"
              @conteo_diagnosticos[2] += 1
            when "Intuitivo"
              @conteo_diagnosticos[3] += 1
            when "Lógico - Formal"
              @conteo_diagnosticos[4] += 1
            when "Lógico - Emotivo"
              @conteo_diagnosticos[5] += 1
            when "Lógico - Intuitivo"
              @conteo_diagnosticos[6] += 1
            when "Formal - Emotivo"
              @conteo_diagnosticos[7] += 1
            when "Formal - Intuitivo"
              @conteo_diagnosticos[8] += 1
            when "Emotivo - Intuitivo"
              @conteo_diagnosticos[9] += 1
            when "Lógico - Formal - Emotivo"
              @conteo_diagnosticos[10] += 1
            when "Lógico - Formal - Intuitivo"
              @conteo_diagnosticos[11] += 1
            when "Lógico - Emotivo - Intuitivo"
              @conteo_diagnosticos[12] += 1
            when "Formal - Emotivo - Intuitivo"
              @conteo_diagnosticos[13] += 1
            when "Lógico - Formal - Emotivo - Intuitivo"
              @conteo_diagnosticos[14] += 1
            end

            case valores.par_dominante
            when "Realista"
              @conteo_diagnosticos_par[0] += 1
            when "Idealista"
              @conteo_diagnosticos_par[1] += 1
            when "Cognitivo"
              @conteo_diagnosticos_par[2] += 1
            when "Instintivo"
              @conteo_diagnosticos_par[3] += 1
            when "Balanceado"
              @conteo_diagnosticos_par[4] += 1
            when "Inventor"
              @conteo_diagnosticos_par[5] += 1
            when "Plsnificado"
              @conteo_diagnosticos_par[6] += 1
            when "Colaborativo"
              @conteo_diagnosticos_par[7] += 1
            when "Implementador"
              @conteo_diagnosticos_par[8] += 1
            when "Ejecutivo"
              @conteo_diagnosticos_par[9] += 1
            when "Traductor"
              @conteo_diagnosticos_par[10] += 1
            end
        end

        if (@cant_usuarios != 0)
            totalL = totalL/@cant_usuarios.to_f
            totalL = round_to_n_decimals(totalL,2)
            totalF = totalF/@cant_usuarios.to_f
            totalF = round_to_n_decimals(totalF,2)
            totalE = totalE/@cant_usuarios.to_f
            totalE = round_to_n_decimals(totalE,2)
            totalI = totalI/@cant_usuarios.to_f
            totalI = round_to_n_decimals(totalI,2)
        end
        # Totales para cada rasgo de la prueba
        @totales = {:logico => totalL, :formal => totalF, :emotivo => totalE, :intuitivo => totalI}

        
        @rasgos = Rasgo.find_all_by_prueba_id(@prueba.id.to_s)
        ## 0 es Lógico, 1 es Formal, 2 es Emotivo, 3 es Intuitivo

        lista_respuestas = []
        lista_evaluaciones.each do |item_eval|
          #un array con todas las respuestas de todas las evaluaciones escogidas
          lista_respuestas = lista_respuestas + item_eval.respuestas.all
        end

        lista_respuestas = lista_respuestas.sort_by(&:alternativa_id )

        @lista_hashes = []
        if (lista_respuestas.length > 0)
            @prueba.preguntas.each do |pregunta|
              preg_ord = pregunta.orden
              alternativas = pregunta.alternativas.all
              sumaL = 0
              sumaF = 0
              sumaE = 0
              sumaI = 0
              textoL = 0
              textoF = 0
              textoE = 0
              textoI = 0
              alternativas.each do |alternativa|
                  contador = 0
                  lista_indx = []
                  lista_respuestas.each_with_index do |elem, indx|
                      break if contador >= @cant_usuarios #creo que el valor deberia ser solo el nro de evaluaciones ya que solo capturo 1 alternativas no 4
                      if ((elem.pregunta_id == pregunta.id) && (elem.alternativa_id == alternativa.id))
                          if (elem.rasgo_id == @rasgos[0].id) #Si es lógico
                            sumaL = sumaL + elem.puntaje
                            textoL = alternativa.texto
                          elsif (elem.rasgo_id == @rasgos[1].id) #Si es formal
                            sumaF = sumaF + elem.puntaje
                            textoF = alternativa.texto
                          elsif (elem.rasgo_id == @rasgos[2].id) #Si es emotivo
                            sumaE = sumaE + elem.puntaje
                            textoE = alternativa.texto
                          elsif (elem.rasgo_id == @rasgos[3].id) #Si es intuitivo
                            sumaI = sumaI + elem.puntaje
                            textoI = alternativa.texto
                          end
                          lista_indx << indx
                          contador = contador + 1
                      end
                  end
                  lista_indx.reverse_each do |itm|
                      # Borro los elementos utilizados
                      lista_respuestas.delete_at(itm)
                  end

              end
              #Aumento el array de hashes
              @lista_hashes << {:orden => preg_ord, :pregunta => pregunta.texto, :logico => round_to_n_decimals(sumaL/@cant_usuarios.to_f,2), :formal => round_to_n_decimals(sumaF/@cant_usuarios.to_f,2), :emotivo => round_to_n_decimals(sumaE/@cant_usuarios.to_f,2), :intuitivo => round_to_n_decimals(sumaI/@cant_usuarios.to_f,2), :txtL => textoL, :txtF => textoF, :txtE => textoE, :txtI => textoI}
            end
        end
        # Cierre: Datos para la consulta de evaluaciones
        @code = rand(4321)

        session[:rpt_prueba] = @prueba
        session[:rpt_cant_usuarios] = @cant_usuarios
        session[:rpt_filtros] = @filtros
        session[:rpt_totales] = @totales
        session[:rpt_lista_hashes] = @lista_hashes
        session[:rpt_tipo] = "promedios"
        session[:rpt_codigo] = @code
        session[:conteo_diagnosticos] = @conteo_diagnosticos
        session[:conteo_diagnosticos_par] = @conteo_diagnosticos_par

        # Puntos para el Google-Chart
        arreglo_graph = [session[:rpt_totales][:logico], session[:rpt_totales][:formal], session[:rpt_totales][:emotivo], session[:rpt_totales][:intuitivo]]

        # Calculo de valores de imagen
        @p2 = arreglo_graph[3] #intuitivo
        @p4 = arreglo_graph[2] #emotivo
        @p6 = arreglo_graph[1] #formal
        @p8 = arreglo_graph[0] #logico

        @p1 = (calcularx(@p8,@p2)/100)*100 #logico-intuitivo
        @p3 = (calcularx(@p2,@p4)/100)*100 #intuitivo-emotivo
        @p5 = (calcularx(@p4,@p6)/100)*100 #emotivo-formal
        @p7 = (calcularx(@p6,@p8)/100)*100 #formal-logico
        # Fin Puntos Google-Chart
        
        @graph = open_flash_chart_object(600,300,"/reportes/graph_code_radar")
        # Despliegue:
        #@graph = open_flash_chart_object(600,300,"/TestPsicologico/reportes/graph_code_radar", true, "/TestPsicologico/")

    end
  end


  def dominancia
    if ((session["usuario"])&&(session["usuario"].administrador == true))
        # Datos para la consulta de usuarios coincidentes
        valores = params[:formulario]
        @prueba = Prueba.find(valores["prueba_id"])
        @filtros = []

        sql = "select * from usuarios "
        condiciones = ""


        if (valores["institucion_id"] != "")
          nombre_institucion = Institucion.find(valores["institucion_id"]).nombre
          @filtros << {:campo => 'Institución', :valor => nombre_institucion }
          if (condiciones == "")
            condiciones = "where institucion_id = '"+valores["institucion_id"].to_s + "'"
          else
            condiciones = condiciones + " and institucion_id = '"+valores["institucion_id"].to_s + "'"
          end
        end
        if (valores["sexo"] != "No especificar")
          @filtros << {:campo => 'Sexo', :valor => valores["sexo"].to_s }
          if (condiciones == "")
            condiciones = "where sexo = '"+valores["sexo"].to_s + "'"
          else
            condiciones = condiciones + " and sexo = '"+valores["sexo"].to_s + "'"
          end
        end
        if (valores["escuela"] != "No especificar")
          @filtros << {:campo => 'Colegio', :valor => valores["escuela"]}
          if (condiciones == "")
            condiciones = "where tipo_colegio = '"+valores["escuela"].to_s + "'"
          else
            condiciones = condiciones + " and tipo_colegio = '"+valores["escuela"].to_s + "'"
          end
        end

        # Lugar de nacimiento
        if (valores["lugar_nacimiento"] != "No especificar")
          @filtros << {:campo => 'Ubicación general', :valor => valores["lugar_nacimiento"]}
          if (condiciones == "")
            condiciones = "where ubicacion_macro = '"+valores["lugar_nacimiento"].to_s + "'"
            if (valores["ubicacion_micro"] != "No especificar")
              @filtros << {:campo => 'Ubicación específica', :valor => valores["ubicacion_micro"]}
              condiciones = condiciones + " and ubicacion_micro = '"+valores["ubicacion_micro"].to_s + "'"
            end
          else
            condiciones = condiciones + " and ubicacion_macro = '"+valores["lugar_nacimiento"].to_s + "'"
            if (valores["ubicacion_micro"] != "No especificar")
              @filtros << {:campo => 'Ubicación específica', :valor => valores["ubicacion_micro"]}
              condiciones = condiciones + " and ubicacion_micro = '"+valores["ubicacion_micro"].to_s + "'"
            end
          end
        end

        # Todo lo referente a universidad
        if (valores["consulta_universidad"] != "No especificar")
          @filtros << {:campo => 'Universidad', :valor => valores["consulta_universidad"]}
          if (condiciones == "")
            if (valores["consulta_universidad"] == "Si")
              condiciones = "where consulta_universidad = true"
            else
              condiciones = "where consulta_universidad = false"
            end
          else
            if (valores["consulta_universidad"] == "Si")
              condiciones = condiciones + " and consulta_universidad = true"
            else
              condiciones = condiciones + " and consulta_universidad = false"
            end
          end
          if (valores["consulta_universidad"] == "Si")
            if (valores["carrera_id"] != "")
                nombre_carrera = Carrera.find(valores["carrera_id"]).nombre
                @filtros << {:campo => 'Carrera', :valor => nombre_carrera }
                condiciones = condiciones + " and carrera_id = " + valores["carrera_id"].to_s
                if ((valores["carrera_id"] == "Psicología") && (valores["especialidad"] != "No especificar"))
                    @filtros << {:campo => 'Especialidad', :valor => valores["especialidad"] }
                    condiciones = condiciones + " and nombre_especialidad = " + valores["especialidad"].to_s
                end
            end
            if (valores["universidad_ingreso"] != "")
                @filtros << {:campo => 'Año de ingreso a la universidad', :valor => valores["universidad_ingreso"] }
                condiciones = condiciones + " and anio_ingreso_universidad = " + valores["universidad_ingreso"].to_s
            end
            if (valores["consulta_egresado"] != "No especificar")
                @filtros << {:campo => 'Egresado', :valor => valores["consulta_egresado"] }
                if (valores["consulta_egresado"] == "Si")
                  condiciones = condiciones + " and consulta_egresado = true"
                else
                  condiciones = condiciones + " and consulta_egresado = false"
                end
                if (valores["consulta_egresado"] == "Si") && (valores["universidad_egreso"] != "")
                  @filtros << {:campo => 'Año de egreso de la universidad', :valor => valores["universidad_egreso"] }
                  condiciones = condiciones + " and anio_egreso_universidad = " + valores["universidad_egreso"].to_s
                end
            end
          end
        end
        # Finally: No admin
        if (condiciones == "")
           condiciones = "where administrador = false"
        else
           condiciones = condiciones + " and administrador = false"
        end


        sql = sql + condiciones
        usuarios = Usuario.find_by_sql sql
        # Cierre: Datos para la consulta de usuarios coincidentes

        @lista_hashes = []
        # Condiciones para la consulta de evaluaciones
        condiciones_eval = "prueba_id = " + @prueba.id.to_s
        if (valores["edad"] != "")
          @filtros << {:campo => 'Edad', :valor => valores["edad"].to_s }
          if (condiciones_eval == "")
            condiciones_eval = "edad = " + valores["edad"].to_s
          else
            condiciones_eval = " and edad = " + valores["edad"].to_s
          end
        end
        if ((valores["institucion_id"] != "") && (valores["tag"] != ""))
          @filtros << {:campo => 'Tag', :valor => valores["tag"] }
          if (condiciones_eval == "")
            condiciones_eval = "tag_codigo = " + valores["tag"].to_s
          else
            condiciones_eval = condiciones_eval + " and tag_codigo = " + valores["tag"].to_s
          end
        end
        if (valores["consulta_fechas"]=="1")
            @filtros << {:campo => 'Fecha inicio', :valor => valores["fecha_inicio"].to_date.to_s }
            @filtros << {:campo => 'Fecha fin', :valor => valores["fecha_fin"].to_date.to_s }
            if (condiciones_eval == "")
              condiciones_eval = "fecha >= '" + valores["fecha_inicio"].to_date.to_s + "' and fecha <= '" + (valores["fecha_fin"].to_date + 1.days).to_s + "'"
            else
              condiciones_eval = condiciones_eval + " and fecha >= '" + valores["fecha_inicio"].to_date.to_s + "' and fecha <= '" + (valores["fecha_fin"].to_date + 1.days).to_s + "'"
            end
        end

        condiciones_eval

        usuarios.each do |individuo|
          #buscar las evaluaciones para este individuo, tomo la mas vieja que este dentro de los
          #parametros de busqueda si hay coincidencias. Luego lo añado a mi lista.
            evals = individuo.evaluacions.find(:all, :conditions => condiciones_eval) #-------> añadir las condiciones
            if (evals.length != 0)
                @lista_hashes << {:nombre => individuo.nombre, :evaluacion => evals[evals.length - 1]}
            end

        end
        @cant_usuarios = @lista_hashes.length #cantidad de usuarios tomados
        @code = rand(4321)

        session[:rpt_prueba] = @prueba
        session[:rpt_cant_usuarios] = @cant_usuarios
        session[:rpt_filtros] = @filtros
        session[:rpt_lista_hashes] = @lista_hashes
        session[:rpt_tipo] = "dominancia"
        session[:rpt_codigo] = @code

    end
  end


  def graph_code_radar

    chart = OpenFlashChart.new
    chart.set_title(Title.new('Perfil de la Dominancia Cerebral de Herrmann'))
    line_2 = LineDot.new


    arreglo = [session[:rpt_totales][:logico], session[:rpt_totales][:formal], session[:rpt_totales][:emotivo], session[:rpt_totales][:intuitivo]]
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
    line_2.set_key( "Muestra", 10 )
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
