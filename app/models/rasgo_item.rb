class RasgoItem
  attr_reader :rasgo, :identificador_rasgo

  def initialize(rasgo, indice)
    @rasgo = rasgo
    @identificador_rasgo = indice
  end

  def nombre
    @rasgo.nombre
  end
end
