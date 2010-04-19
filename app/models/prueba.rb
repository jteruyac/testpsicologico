class Prueba < ActiveRecord::Base
  has_many :evaluacions
  has_many :preguntas
end
