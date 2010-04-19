class CreateEvaluacions < ActiveRecord::Migration
  def self.up
    create_table :evaluacions do |t|
      t.integer :usuario_id
      t.integer :prueba_id
      t.datetime :fecha
      t.integer :puntaje_logico
      t.integer :puntaje_formal
      t.integer :puntaje_emotivo
      t.integer :puntaje_intuitivo
      t.string :tipo_dominante
      t.integer :edad
      t.string :tag_codigo
      t.integer :puntaje_realista
      t.integer :puntaje_idealista
      t.integer :puntaje_cognitivo
      t.integer :puntaje_instintivo
      t.string :par_dominante

      t.timestamps
    end
  end

  def self.down
    drop_table :evaluacions
  end
end
