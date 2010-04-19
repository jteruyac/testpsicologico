class PruebaPreguntas
  attr_reader :preguntas, :rasgos, :indice_preguntas, :modificacion, :nueva_version

  def initialize
    @preguntas = []
    @rasgos = []
    @indice_preguntas = 1;
    @indice_rasgos = 1;
    @prueba = nil
    @modificacion = false # indica si el caso de uso es edit o new

    logico = Rasgo.new
    formal = Rasgo.new
    emotivo = Rasgo.new
    intuitivo = Rasgo.new

    logico.nombre = 'Lógico'
    formal.nombre = 'Formal'
    emotivo.nombre = 'Emotivo'
    intuitivo.nombre = 'Intuitivo'

    logico.descripcion = "Comportamientos: Frío, distante; pocos gestos; voz elaborada; intelectualmente brillante; evalúa, critica; irónico; le gustan las citas; competitivo; individualista.
Procesos: Análisis; razonamiento; lógica; rigor, claridad; le gustan los modelos y las teorías; colecciona hechos; procede por hipótesis; le gusta la palabra precisa.
Competencias: Abstracción; matemático; cuantitativo; finanzas; técnico; resolución de problemas"
    formal.descripcion = "Comportamientos: Introvertido; emotivo, controlado; minucioso, maniático; monologa; le gustan las fórmulas; conservador, fiel; defiende su territorio; ligado a la experiencia, ama el poder.
Procesos: Planifica; formaliza; estructura; define los procedimientos; secuencial; verificador; ritualista; metódico.
Competencias: Administración; organización; realización, puesta en marcha; conductor de hombres; orador; trabajador consagrado."
    emotivo.descripcion = "Comportamientos: Extravertido; emotivo; espontáneo; gesticulador; lúdico; hablador; idealista, espiritual; busca aquiescencia; reacciona mal a las críticas.
Procesos: Integra por la experiencia; se mueve por el principio del placer; fuerte implicación afectiva; trabaja con sentimientos; escucha, pregunta; necesidad de compartir; necesidad de armonía; evalúa los comportamientos.
Competencias: Relacional; contactos humanos; diálogo; enseñanza; trabajo en equipo; expresión oral y escrita."
    intuitivo.descripcion = "Comportamientos: Original; humor; gusto por el riesgo; espacial; simultáneo; le gustan las discusiones; futurista; salta de un tema a otro; discurso brillante; independiente.
Procesos: Conceptualización; síntesis; globalización; imaginación; intuición; visualización; actúa por asociaciones; integra por medio de imágenes y metáforas.
Competencias: Creación; innovación; espíritu de empresa; artista; investigación; visión de futuro."

    add_rasgo(logico)
    add_rasgo(formal)
    add_rasgo(emotivo)
    add_rasgo(intuitivo)

  end

  def modo_editar(rasgo_l, rasgo_f, rasgo_e, rasgo_i)
    #Tengo que ejecutar esto antes de cargar cualquier pregunta
    logico = rasgo_l
    formal = rasgo_f
    emotivo = rasgo_e
    intuitivo = rasgo_i
    @modificacion = true
    @rasgos = []
    @indice_rasgos = 1
    add_rasgo(logico)
    add_rasgo(formal)
    add_rasgo(emotivo)
    add_rasgo(intuitivo)
  end

  def get_prueba
    @prueba ||= Prueba.new
  end

  def set_prueba(data)
    @prueba = data
  end

  def add_pregunta(pregunta)
    @preguntas << PreguntaItem.new(pregunta, @indice_preguntas, true)
    @indice_preguntas +=1
  end

  def add_pregunta_antigua(pregunta)
    element = PreguntaItem.new(pregunta, @indice_preguntas, false)
    
    pregunta.alternativas.each do |sth|
      valor = sth.rasgo_id
      un_rasgo = @rasgos.find {|opcion| opcion.rasgo.id == valor}
      sth.rasgo_id = un_rasgo.identificador_rasgo
    end


    pregunta.alternativas.each do |item|
      element.add_alternativa(item)
      #las alternativas se estan guardando con un rasgo_id que no es.
    end
    @preguntas << element
    @indice_preguntas +=1
  end

  def add_rasgo(rasgo)
    @rasgos << RasgoItem.new(rasgo, @indice_rasgos)
    @indice_rasgos +=1
  end

  def update_alternativa(alternativa, id)
    @current_pregunta = @preguntas.find {|pregunta| pregunta.identificador_pregunta == alternativa.pregunta_id}
    if @current_pregunta
      @current_alternativa = @current_pregunta.alternativas.find {|opcion| opcion.identificador_alternativa == id}
      if @current_alternativa
        if @current_pregunta.pregunta_nueva
            @current_alternativa.update_alternativa(alternativa)
        else # es pregunta antigua
            @current_alternativa.update_alternativa_only_text(alternativa.texto)
        end
      end
    end
  end


  def drop_pregunta(identidad)
    index = -1
    @preguntas.each do |preguntaItem|
      if (preguntaItem.identificador_pregunta.to_s == identidad)
        index = @preguntas.index(preguntaItem)
      end
    end
    @preguntas.delete_at(index)
  end

  def drop_pregunta_edit(identidad)
    index = -1
    marcar = false
    @preguntas.each do |preguntaItem|
      if (preguntaItem.identificador_pregunta.to_s == identidad)
        index = @preguntas.index(preguntaItem)
        if (preguntaItem.pregunta_nueva == false)
          marcar = true
        end
      end
    end
    if marcar == false
        @preguntas.delete_at(index)
    else
        #metodo para marcar
        @preguntas[index].inhabilitar
    end
  end


  def nueva_version? #esta funcion se llama en el metodo orquestar_update en pruebas_controller
    flag = false #cambios sobre la version actual
    @preguntas.each do |pregunta|
      if ((pregunta.pregunta_nueva == true) || ((pregunta.eliminar_luego == true) && (pregunta.pregunta_nueva == false)))
        flag = true #se generará una nueva version
      end
    end
    flag
  end

  def numero_preguntas? #esta funcion se llama en el metodo orquestar_update en pruebas_controller
    numero = 0
    @preguntas.each do |thng|
      if !thng.eliminar_luego
        numero =  numero + 1
      end
    end
    return numero
  end

end

# a.delete_if { |i| i == 7 }


# @current_item = @items.find {|item| item.product == product}
# if @current_item
#   @current_item.increment_quantity
# else
#   @items << CarroItem.new(product)
# end