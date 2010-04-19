class Pregunta < ActiveRecord::Base
  belongs_to :prueba
  has_many :alternativas
  has_many :respuestas
end
