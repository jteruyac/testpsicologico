class CreateAlternativas < ActiveRecord::Migration
  def self.up
    create_table :alternativas do |t|
      t.integer :rasgo_id
      t.integer :pregunta_id
      t.text :texto

      t.timestamps
    end
  end

  def self.down
    drop_table :alternativas
  end
end
