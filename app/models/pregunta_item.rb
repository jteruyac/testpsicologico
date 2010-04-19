class PreguntaItem
  attr_reader :pregunta, :alternativas, :identificador_pregunta, :pregunta_nueva, :eliminar_luego
  
  def initialize(pregunta, indice, nueva)
    @pregunta = pregunta
    @identificador_pregunta = indice
    @alternativas = []
    @indice_alternativas = 1
    @eliminar_luego = false #solo se toma en cuenta si la pregunta es antigua

    if (nueva)
      #solo se verifica si se esta editando el test
      @pregunta_nueva = true
      # creando las 4 alternativas
      add_alternativa(Alternativa.new)
      add_alternativa(Alternativa.new)
      add_alternativa(Alternativa.new)
      add_alternativa(Alternativa.new)
    else
      @pregunta_nueva = false
    end
  end

  def add_alternativa(alternativa)
    alternativa.pregunta_id = @identificador_pregunta
    @alternativas << AlternativaItem.new(alternativa, @indice_alternativas)
    @indice_alternativas +=1
  end

  def inhabilitar
    @eliminar_luego = true
  end
end
