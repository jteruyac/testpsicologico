class InsertPuebaTest < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO preguntas (id,prueba_id,texto,orden,invalidar,created_at,updated_at) VALUES
 (1,1,'Cuando voy a viajar:',1,false,'2010-06-07 00:22:24','2010-06-07 00:22:24'),
 (2,1,'Cuando estoy terminando un trabajo:',2,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (3,1,'Cuando me muestran un objeto novedoso, lo primero que pienso es:',3,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (4,1,'Cuando me encuentro bloqueado por algún obstáculo:',4,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (5,1,'Si te ganaras la lotería:',5,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (6,1,'Prefiero ir a un evento social para disfrutar de:',6,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (7,1,'Antes de tomar una decisión:',7,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (8,1,'Cuando un problema se presenta:',8,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (9,1,'Cuando me dan un teléfono que me interesa:',9,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (10,1,'Antes de entregar un trabajo:',10,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (11,1,'La primera impresión que me gustaría proyectar, es que soy una persona:',11,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (12,1,'Cuando leo una noticia me preocupo más por:',12,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (13,1,'Si obtengo dinero:',13,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (14,1,'Si veo un accidente:',14,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (15,1,'Suelo comprender las cosas en base a:',15,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (16,1,'Cuando trabajo, me preocupo más por:',16,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (17,1,'Cuando tengo tiempo libre:',17,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (18,1,'Las personas aprenden más cuando:',18,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (19,1,'Cuando expongo una idea, me gusta ser:',19,false,'2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (20,1,'En un trabajo valoro:',20,false,'2010-06-07 00:22:25','2010-06-07 00:22:25')"
    execute "ALTER SEQUENCE preguntas_id_seq RESTART WITH 21;"
  end

  def self.down
  end
end
