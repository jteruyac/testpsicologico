class UsuariosController < ApplicationController
  include ApplicationHelper
  # GET /usuarios
  # GET /usuarios.xml
  def index
    check_timeout

    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @usuarios = Usuario.find(:all, :conditions => 'administrador = false', :include => [:carrera, :institucion])
      session[:time] = Time.now
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @usuarios }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.xml
  def show
    check_timeout

    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @usuario = Usuario.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @usuario }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    @usuario = Usuario.new
    @institucions = Institucion.all
    @carreras = Carrera.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @institucions = Institucion.all
    @usuario = Usuario.find(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.xml
  def create
    @usuario = Usuario.new(params[:usuario])
    #    fechaArray = params[:usuario][:fecha_nacimiento].split("/")
    #    fecha = DateTime.new( y = fechaArray[2].to_i, m = fechaArray[1].to_i, d = fechaArray[0].to_i, h = 0, min = 0, s = 0)
    #    @usuario.fecha_nacimiento = fecha
    @usuario.administrador = false
    mayor = true
    coincidente = Usuario.find_by_usuario(@usuario.usuario)

    if ((@usuario.consulta_egresado) && (@usuario.anio_egreso_universidad) && ((@usuario.anio_ingreso_universidad.to_i+3) >= @usuario.anio_egreso_universidad.to_i))
      mayor = false
    end

    respond_to do |format|
      if ((!coincidente) && (@usuario.fecha_nacimiento) && (@usuario.fecha_nacimiento < (Time.now-10.years).to_datetime) && (@usuario.fecha_nacimiento.year.to_i >= 1900) && (mayor) && (@usuario.save))
        flash[:notice] = 'Usuario creado con éxito'
        format.html { redirect_to(:controller => :main, :action => :login) }
        format.xml  { render :xml => @usuario, :status => :created, :location => @usuario }
      else
        @carreras = Carrera.all
        @institucions = Institucion.all
        flash[:notice] = '-1000'
        if (!mayor)
          flash[:notice] = '-3500'
        end
        if ((!@usuario.fecha_nacimiento) || (@usuario.fecha_nacimiento > (Time.now-10.years).to_datetime) || (@usuario.fecha_nacimiento.year.to_i < 1900))
          flash[:notice] = '-9000'
        end
        format.html { render :action => "new" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        flash[:anuncio0] = "Usuario modificado correctamente."
        format.html { redirect_to(:controller => :usuarios, :action => :index) }
        format.xml  { head :ok }
      else
        @carreras = Carrera.all
        @institucions = Institucion.all
        format.html { render :action => "edit" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @usuario = Usuario.find(params[:id])
    @pruebas = Prueba.all
    @pruebas.each do |prueba|
      evaluacion = Evaluacion.find(:all, :include => :respuestas , :conditions => "prueba_id = "+ prueba.id.to_s+" and usuario_id = "+@usuario.id.to_s)
      evaluacion.each do |item_e|
      item_e.respuestas.each do |item_r|
        item_r.destroy
      end
      item_e.destroy
      end
    end
    
    @usuario.destroy

    respond_to do |format|
      flash[:anuncio0] = "Usuario eliminado correctamente."
      format.html { redirect_to(usuarios_url) }
      format.xml  { head :ok }
    end
  end
end
