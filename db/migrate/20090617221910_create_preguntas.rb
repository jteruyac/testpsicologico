class CreatePreguntas < ActiveRecord::Migration
  def self.up
    create_table :preguntas do |t|
      t.integer :prueba_id
      t.text :texto
      t.integer :orden
      t.boolean :invalidar

      t.timestamps
    end
  end

  def self.down
    drop_table :preguntas
  end
end
