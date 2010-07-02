class CarrerasController < ApplicationController
  include ApplicationHelper
  # GET /carreras
  # GET /carreras.xml
  def index
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @carreras = Carrera.all
      session[:time] = Time.now

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @carreras }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /carreras/1
  # GET /carreras/1.xml
  def show
    check_timeout

    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @carrera = Carrera.find(params[:id])
      session[:time] = Time.now
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @carrera }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /carreras/new
  # GET /carreras/new.xml
  def new
    check_timeout

    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @carrera = Carrera.new
      @carreras = Carrera.all
      session[:time] = Time.now
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @carrera }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /carreras/1/edit
  def edit
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @carrera = Carrera.find(params[:id])
      session[:time] = Time.now
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # POST /carreras
  # POST /carreras.xml
  def create
    @carrera = Carrera.new(params[:carrera])
    @carreras = Carrera.all

    repetido_c = false
    @carreras.each do |dos|
      if @carrera.nombre == dos.nombre
        repetido_c = true
      end
    end

    if !repetido_c
      if @carrera.save
        redirect_to carreras_path
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @carrera.errors, :status => :unprocessable_entity }
      end
    else
      flash[:notice] = 'Error 10'
      redirect_to :controller => :carreras, :action => :new
    end
   
  end

  # PUT /carreras/1
  # PUT /carreras/1.xml
  def update
    @carrera = Carrera.find(params[:id])

    respond_to do |format|
      if @carrera.update_attributes(params[:carrera])
        flash[:notice] = 'Carrera was successfully updated.'
        redirect_to carrera_path
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @carrera.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carreras/1
  # DELETE /carreras/1.xml
  def destroy
    @carrera = Carrera.find(params[:id])
    identidad = @carrera.id
    @carrera.destroy

    @usuarios = Usuario.all(:conditions => "carrera_id = "+identidad.to_s)
    @usuarios.each do |elems|
      elems.update_attribute("carrera_id", nil)
      elems.update_attribute("nombre_especialidad", nil)
    end

    respond_to do |format|
      format.html { redirect_to(carreras_url) }
      format.xml  { head :ok }
    end
  end
end
