pdf.text "Perfil de la dominancia cerebral de Herrmann", :size => 22, :style => :bold
pdf.move_down(10)
pdf.text "[ Test Psicológico: " + @prueba_nombre + "  |  " + "Persona Evaluada: " + @indiv + " ]", :size => 12
pdf.move_down(15)
pdf.image open(@urii), :position => :center, :width => 320, :height => 300
pdf.move_down(5)
pdf.text "Puntajes Obtenidos", :align => :center, :size => 15
pdf.move_down(3)

pdf.table @matriz_simple,
    :position => :center,
    :headers => @matriz_simple_head,
    :row_colors => ['ffffff','95CEF3'],
    :vertical_padding => 5,
    :horizontal_padding => 3,
    :font_size => 10
pdf.move_down(15)
pdf.text "Estilo Dominante: "+@diagnostico, :size => 15, :align => :center
pdf.move_down(5)

@recomendacion_diagnostico.each do |item|
    pdf.text "Estilo " + item["nombre"] + ": ", :style => :bold, :size => 10
    pdf.text item["texto"], :size => 9
end

pdf.start_new_page()
pdf.text "Análisis Compuesto", :align => :center, :size => 15
pdf.move_down(10)
pdf.table @matriz_compuesta,
    :position => :center,
    :headers => @matriz_compuesta_head,
    :row_colors => ['ffffff','95CEF3'],
    :vertical_padding => 5,
    :horizontal_padding => 3,
    :font_size => 10

pdf.move_down(15)
pdf.text "Combinación Dominante: "+@diagnostico_par, :size => 15, :align => :center
pdf.move_down(5)
pdf.text "Perfil " + @diagnostico_par + ": ", :style => :bold, :size => 10
pdf.text @recomendacion_diagnostico_par, :size => 9