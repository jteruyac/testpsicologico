class Evaluacion < ActiveRecord::Base
  belongs_to :usuario
  belongs_to :prueba
  has_many :respuestas
end
