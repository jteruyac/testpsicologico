class CreateRespuestas < ActiveRecord::Migration
  def self.up
    create_table :respuestas do |t|
      t.integer :evaluacion_id
      t.integer :pregunta_id
      t.integer :alternativa_id
      t.integer :puntaje
      t.integer :rasgo_id
      t.timestamps
    end
  end

  def self.down
    drop_table :respuestas
  end
end
