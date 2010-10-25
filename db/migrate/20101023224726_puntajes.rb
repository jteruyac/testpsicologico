class Puntajes < ActiveRecord::Migration
  def self.up
    add_column :evaluacions, :puntaje_balanceado, :integer
    add_column :evaluacions, :puntaje_inventor, :integer
    add_column :evaluacions, :puntaje_planificado, :integer
    add_column :evaluacions, :puntaje_colaborativo, :integer
    add_column :evaluacions, :puntaje_implementador, :integer
    add_column :evaluacions, :puntaje_ejecutivo, :integer
    add_column :evaluacions, :puntaje_traductor, :integer
  end

  def self.down
  end
end
