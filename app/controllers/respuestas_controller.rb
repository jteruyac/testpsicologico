class RespuestasController < ApplicationController
  # GET /respuestas
  # GET /respuestas.xml
  def index

    @respuestas = Respuesta.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @respuestas }
    end
  end

  # GET /respuestas/1
  # GET /respuestas/1.xml
  def show
    @respuesta = Respuesta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @respuesta }
    end
  end

  # GET /respuestas/new
  # GET /respuestas/new.xml
  def new
    @respuesta = Respuesta.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @respuesta }
    end
  end

  # GET /respuestas/1/edit
  def edit
    @respuesta = Respuesta.find(params[:id])
  end

  # POST /respuestas
  # POST /respuestas.xml
  def create
    @respuesta = Respuesta.new(params[:respuesta])

    respond_to do |format|
      if @respuesta.save
        flash[:notice] = 'Respuesta was successfully created.'
        format.html { redirect_to(@respuesta) }
        format.xml  { render :xml => @respuesta, :status => :created, :location => @respuesta }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @respuesta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /respuestas/1
  # PUT /respuestas/1.xml
  def update
    @respuesta = Respuesta.find(params[:id])

    respond_to do |format|
      if @respuesta.update_attributes(params[:respuesta])
        flash[:notice] = 'Respuesta was successfully updated.'
        format.html { redirect_to(@respuesta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @respuesta.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /respuestas/1
  # DELETE /respuestas/1.xml
  def destroy
    @respuesta = Respuesta.find(params[:id])
    @respuesta.destroy

    respond_to do |format|
      format.html { redirect_to(respuestas_url) }
      format.xml  { head :ok }
    end
  end

end