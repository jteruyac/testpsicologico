class CreateUsuarios < ActiveRecord::Migration
  def self.up
    create_table :usuarios do |t|
      t.string :nombre
      t.string :usuario
      t.string :password
      t.datetime :fecha_nacimiento
      t.string :sexo
      t.boolean :administrador
      t.string :ubicacion_macro
      t.string :ubicacion_micro
      t.string :tipo_colegio
      t.string :nombre_colegio
      t.boolean :consulta_universidad
      t.string :nombre_universidad
      t.integer :carrera_id
      t.string :nombre_especialidad
      t.boolean :consulta_egresado
      t.string :anio_ingreso_universidad
      t.string :anio_egreso_universidad
      t.integer :institucion_id

      #t.integer :semestres_cursados
      #t.integer :ciclo_actual
      t.timestamps
    end
  end

  def self.down
    drop_table :usuarios
  end
end
