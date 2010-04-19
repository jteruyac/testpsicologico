class CreateManagerUser < ActiveRecord::Migration
  def self.up
    Usuario.create(:nombre => "Administrador", :usuario => "EstilosLG", :password => "12345654321", :administrador => true)
  end

  def self.down
  end
end
