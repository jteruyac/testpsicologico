class CreateRasgos < ActiveRecord::Migration
  def self.up
    create_table :rasgos do |t|
      t.integer :prueba_id
      t.string :nombre
      t.text :descripcion

      t.timestamps
    end
  end

  def self.down
    drop_table :rasgos
  end
end
