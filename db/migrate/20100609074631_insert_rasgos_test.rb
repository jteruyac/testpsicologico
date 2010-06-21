class InsertRasgosTest < ActiveRecord::Migration
  def self.up
    execute "INSERT INTO rasgos (`id`,`prueba_id`,`nombre`,`descripcion`,`created_at`,`updated_at`) VALUES
 (1,1,'Lógico','Comportamientos: Frío, distante; pocos gestos; voz elaborada; intelectualmente brillante; evalúa, critica; irónico; le gustan las citas; competitivo; individualista.\nProcesos: Análisis; razonamiento; lógica; rigor, claridad; le gustan los modelos y las teorías; colecciona hechos; procede por hipótesis; le gusta la palabra precisa.\nCompetencias: Abstracción; matemático; cuantitativo; finanzas; técnico; resolución de problemas','2010-06-07 00:22:24','2010-06-07 00:22:24'),
 (2,1,'Formal','Comportamientos: Introvertido; emotivo, controlado; minucioso, maniático; monologa; le gustan las fórmulas; conservador, fiel; defiende su territorio; ligado a la experiencia, ama el poder.\nProcesos: Planifica; formaliza; estructura; define los procedimientos; secuencial; verificador; ritualista; metódico.\nCompetencias: Administración; organización; realización, puesta en marcha; conductor de hombres; orador; trabajador consagrado.','2010-06-07 00:22:24','2010-06-07 00:22:24'),
 (3,1,'Emotivo','Comportamientos: Extravertido; emotivo; espontáneo; gesticulador; lúdico; hablador; idealista, espiritual; busca aquiescencia; reacciona mal a las críticas.\nProcesos: Integra por la experiencia; se mueve por el principio del placer; fuerte implicación afectiva; trabaja con sentimientos; escucha, pregunta; necesidad de compartir; necesidad de armonía; evalúa los comportamientos.\nCompetencias: Relacional; contactos humanos; diálogo; enseñanza; trabajo en equipo; expresión oral y escrita.','2010-06-07 00:22:24','2010-06-07 00:22:24'),
 (4,1,'Intuitivo','Comportamientos: Original; humor; gusto por el riesgo; espacial; simultáneo; le gustan las discusiones; futurista; salta de un tema a otro; discurso brillante; independiente.\nProcesos: Conceptualización; síntesis; globalización; imaginación; intuición; visualización; actúa por asociaciones; integra por medio de imágenes y metáforas.\nCompetencias: Creación; innovación; espíritu de empresa; artista; investigación; visión de futuro.','2010-06-07 00:22:24','2010-06-07 00:22:24')"
  end

  def self.down
  end
end
