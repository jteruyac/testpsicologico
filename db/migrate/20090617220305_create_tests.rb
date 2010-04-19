class CreateTests < ActiveRecord::Migration
  def self.up
    create_table :pruebas do |t|
      t.string :nombre
      t.text :descripcion
      t.text :instrucciones
      t.string :autor
      t.integer :version
      t.integer :numero_preguntas
      t.boolean :publicar
      t.boolean :invalidar

      t.timestamps
    end
  end

  def self.down
    drop_table :tests
  end
end
