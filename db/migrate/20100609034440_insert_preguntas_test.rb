class InsertPreguntasTest < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO pruebas (`id`,`nombre`,`descripcion`,`instrucciones`,`autor`,`version`,`numero_preguntas`,`publicar`,`invalidar`,`created_at`,`updated_at`) VALUES (1,'Estilos de Aprendizaje','Test psicológico elaborado por Liliana Galván Oré en base al modelo de cerebro multidominante de Ned Herrmann. Su propósito es medir la influencia de los estilos del pensamiento en nuestra forma de tomar decisiones.','El test psicológico consta de una lista de situaciones propuestas. Cada una posee cuatro formas de reaccionar ante la situación. Para cada situación se deberám asignar cinco puntos entre una ó dos de sus alternativas.','Liliana Galván Oré',1,20,1,0,'2010-06-07 00:22:24','2010-06-07 00:22:24')"
  end

  def self.down
  end
end
