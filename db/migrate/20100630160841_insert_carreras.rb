class InsertCarreras < ActiveRecord::Migration
  def self.up
    Carrera.create(:nombre => "Arquitectura")
    Carrera.create(:nombre => "Comunicaciones")
    Carrera.create(:nombre => "Derecho")
    Carrera.create(:nombre => "Economía")
    Carrera.create(:nombre => "Ingeniería Civil")
    Carrera.create(:nombre => "Ingeniería Electrónica")
    Carrera.create(:nombre => "Ingeniería Industrial")
    Carrera.create(:nombre => "Ingeniería de Sistemas de Información")
    Carrera.create(:nombre => "Ingeniería de Software")
    Carrera.create(:nombre => "Ingeniería de Telecomunicaciones y Redes")
    Carrera.create(:nombre => "Medicina")
    Carrera.create(:nombre => "Música")
    Carrera.create(:nombre => "Nutrición y Dietética")
    Carrera.create(:nombre => "Negocios Internacionales")
    Carrera.create(:nombre => "Odontología")
    Carrera.create(:nombre => "Psicología")
    Carrera.create(:nombre => "Terapia Física")
  end

  def self.down
  end
end
