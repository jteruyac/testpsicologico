class Rasgo < ActiveRecord::Base
  has_many :respuestas
  has_many :alternativas
  belongs_to :prueba
end
