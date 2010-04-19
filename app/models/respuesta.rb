class Respuesta < ActiveRecord::Base
  belongs_to :rasgo
  belongs_to :alternativa
  belongs_to :evaluacion
  belongs_to :pregunta
end
