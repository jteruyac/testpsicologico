class AlternativaItem
  attr_reader :alternativa, :identificador_alternativa

  def initialize(alternativa, indice)
    @alternativa = alternativa
    @identificador_alternativa = indice
  end

  def update_alternativa(alternativa)
    @alternativa = alternativa
  end

  def update_alternativa_only_text(text)
    @alternativa.texto = text
  end

end
