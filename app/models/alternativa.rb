class Alternativa < ActiveRecord::Base
  belongs_to :pregunta
  belongs_to :rasgo
end
