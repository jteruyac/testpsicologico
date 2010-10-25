# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101023224726) do

  create_table "alternativas", :force => true do |t|
    t.integer  "rasgo_id"
    t.integer  "pregunta_id"
    t.text     "texto"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "carreras", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "evaluacions", :force => true do |t|
    t.integer  "usuario_id"
    t.integer  "prueba_id"
    t.datetime "fecha"
    t.integer  "puntaje_logico"
    t.integer  "puntaje_formal"
    t.integer  "puntaje_emotivo"
    t.integer  "puntaje_intuitivo"
    t.string   "tipo_dominante"
    t.integer  "edad"
    t.string   "tag_codigo"
    t.integer  "puntaje_realista"
    t.integer  "puntaje_idealista"
    t.integer  "puntaje_cognitivo"
    t.integer  "puntaje_instintivo"
    t.string   "par_dominante"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "puntaje_balanceado"
    t.integer  "puntaje_inventor"
    t.integer  "puntaje_planificado"
    t.integer  "puntaje_colaborativo"
    t.integer  "puntaje_implementador"
    t.integer  "puntaje_ejecutivo"
    t.integer  "puntaje_traductor"
  end

  create_table "institucions", :force => true do |t|
    t.string   "nombre"
    t.string   "tipo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "preguntas", :force => true do |t|
    t.integer  "prueba_id"
    t.text     "texto"
    t.integer  "orden"
    t.boolean  "invalidar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pruebas", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.text     "instrucciones"
    t.string   "autor"
    t.integer  "version"
    t.integer  "numero_preguntas"
    t.boolean  "publicar"
    t.boolean  "invalidar"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rasgos", :force => true do |t|
    t.integer  "prueba_id"
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "respuestas", :force => true do |t|
    t.integer  "evaluacion_id"
    t.integer  "pregunta_id"
    t.integer  "alternativa_id"
    t.integer  "puntaje"
    t.integer  "rasgo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "tags", :force => true do |t|
    t.string   "nombre"
    t.string   "codigo"
    t.integer  "institucion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", :force => true do |t|
    t.string   "nombre"
    t.string   "usuario"
    t.string   "password"
    t.datetime "fecha_nacimiento"
    t.string   "sexo"
    t.boolean  "administrador"
    t.string   "ubicacion_macro"
    t.string   "ubicacion_micro"
    t.string   "tipo_colegio"
    t.string   "nombre_colegio"
    t.boolean  "consulta_universidad"
    t.string   "nombre_universidad"
    t.integer  "carrera_id"
    t.string   "nombre_especialidad"
    t.boolean  "consulta_egresado"
    t.string   "anio_ingreso_universidad"
    t.string   "anio_egreso_universidad"
    t.integer  "institucion_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
