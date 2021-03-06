class InsertAlternativasTest < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO alternativas (id,rasgo_id,pregunta_id,texto,created_at,updated_at) VALUES
 (1,2,1,'Me gusta hacer planes y llevarlos a cabo tal como se han pensado','2010-06-07 00:22:24','2010-06-07 00:22:24'),
 (2,3,1,'Hago planes con la gente','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (3,4,1,'Lo hago sin restricciones y con total apertura a las nuevas experiencias','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (4,1,1,'Averiguo todo lo que se refiera al lugar que voy a visitar','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (5,2,2,'Me concentro hasta terminar, así esté cansado','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (6,1,2,'Sólo continúo si estoy en óptimas condiciones de lucidez','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (7,3,2,'Busco compañía para motivarme y acabar','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (8,4,2,'Me las ingenio, variando las actividades por momento','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (9,4,3,'Porqué es así y cómo podría ser mejor','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (10,3,3,'Para qué sirve, cuál es el beneficio','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (11,2,3,'Cómo lo puedo obtener, dónde se encuentra','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (12,1,3,'Qué es y cómo son sus partes','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (13,3,4,'Busco a alguien para conversar y contarle lo que me pasa','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (14,2,4,'Repito el proceso hasta lograr lo que quiero','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (15,1,4,'Me detengo a reflexionar sobre lo que está sucediendo','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (16,4,4,'Trato de hacer otras cosas hasta que me sienta relajado','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (17,4,5,'Viajaría por todo el mundo','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (18,1,5,'Realizaría un gran negocio','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (19,3,5,'Lo invertiría en alguna institución social','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (20,2,5,'Buscaría mi seguridad para siempre','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (21,3,6,'Situaciones emotivas: fiestas, retiros, reuniones , conciertos, deportivas','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (22,1,6,'Situaciones informativas de tipo intelectual: conferencias, debates, cursos','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (23,4,6,'Situaciones sensitivas-experimentales: espectáculos artísticos, talleres','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (24,2,6,'Situaciones formales: inauguraciones, matrimonios, presentaciones','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (25,1,7,'Analizo las causas y consecuencias de mi decisión','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (26,3,7,'Consulto con otras personas','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (27,2,7,'Analizo los pros y los contras minuciosamente','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (28,4,7,'Me dejo llevar por mi intuición y experiencia','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (29,1,8,'Me gusta ir directo al grano, sin rodeos','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (30,3,8,'Examino las impresiones de las personas','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (31,2,8,'Me gusta conocer al máximo todos los detalles del problema','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (32,4,8,'Me baso en mi intuición para comprender lo que está pasando','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (33,1,9,'Lo registro mentalmente y lo memorizo','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (34,2,9,'Lo registro en mi agenda inmediatamente','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (35,4,9,'Lo apunto en cualquier papel','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (36,3,9,'No me preocupo por apuntarlo, si lo necesito, lo averiguo','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (37,2,10,'Me aseguro de revisar hasta el más mínimo detalle','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (38,1,10,'Reviso si la estructura general del trabajo es lógica y comprensible','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (39,4,10,'Se me ocurren nuevas ideas cada vez que lo reviso y lo modifico','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (40,3,10,'Lo muestro a diversas personas para que lo revisen y me den opiniones','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (41,3,11,'Muy sensible, que comprende, que alienta','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (42,4,11,'Muy creativa, imaginativa, experimental','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (43,1,11,'Muy razonable, lógica, analítica','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (44,2,11,'Muy paciente, ordenada, realista, práctica','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (45,4,12,'Las ideas y el contexto de donde provienen','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (46,2,12,'El orden de los acontecimientos','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (47,1,12,'Los hechos y evidencias que lo sustentan','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (48,3,12,'Los personajes involucrados','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (49,4,13,'Lo ahorro','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (50,1,13,'Lo comparto con la familia y los amigos','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (51,2,13,'Lo gasto en algo novedoso','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (52,3,13,'Lo invierto en algo seguro','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (53,1,14,'Me pongo a pensar cómo sucedió y observo los acontecimientos','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (54,2,14,'Brindo ayuda de manera práctica e inmediata','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (55,3,14,'Me afecto emocionalmente','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (56,4,14,'Pienso en formas de evitar ese tipo de accidentes, hago críticas y comentarios ','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (57,2,15,'Teorías o estudios sistematizados','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (58,4,15,'Mi intuición','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (59,3,15,'Los sentimientos y la experiencia personal','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (60,1,15,'La lógica, cálculos o probabilidades','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (61,2,16,'La organización y el orden','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (62,1,16,'Lo funcional y técnico','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (63,3,16,'Las relaciones humanas','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (64,4,16,'La visión y la proyección','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (65,2,17,'Me gusta hacer deporte','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (66,1,17,'Me gusta leer','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (67,4,17,'Me gusta practicar juegos de riesgo','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (68,3,17,'Me gusta escuchar música','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (69,3,18,'Sienten emociones','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (70,4,18,'Experimentan','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (71,1,18,'Reflexionan','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (72,2,18,'Toman apuntes','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (73,2,19,'Detallado, ordenado, específico','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (74,3,19,'Afectivo, personal, emotivo','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (75,1,19,'Claro, preciso, breve y directo al punto','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (76,4,19,'Visual, simultáneo, intuitivo','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (77,1,20,'La argumentación o el sustento','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (78,2,20,'La precisión y la calidad','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (79,4,20,'Las propuestas innovadoras','2010-06-07 00:22:25','2010-06-07 00:22:25'),
 (80,3,20,'El compromiso con el trabajo','2010-06-07 00:22:25','2010-06-07 00:22:25')"
    execute "ALTER SEQUENCE alternativas_id_seq RESTART WITH 81;"
  end

  def self.down
  end
end
