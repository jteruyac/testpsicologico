class InstitucionsController < ApplicationController
  # GET /institucions
  # GET /institucions.xml
  def index
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))

      @institucions = Institucion.all
      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @institucions }
      end
      
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /institucions/1
  # GET /institucions/1.xml
  def show
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @institucion = Institucion.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @institucion }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /institucions/new
  # GET /institucions/new.xml
  def new
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @institucion = Institucion.new
      @institucions = Institucion.all

      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @institucion }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /institucions/1/edit
  def edit
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @institucion = Institucion.find(params[:id])
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # POST /institucions
  # POST /institucions.xml
  def create
    @institucion = Institucion.new(params[:institucion])
    @institucions = Institucion.all

    repetido_c = false
    @institucions.each do |dos|
      if @institucion.nombre == dos.nombre
        repetido_c = true
      end
    end

    if !repetido_c
      if @institucion.save
        redirect_to institucions_path
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @institucion.errors, :status => :unprocessable_entity }
      end
    else
      flash[:notice] = 'Error 10'
      redirect_to :controller => :institucions, :action => :new
    end
  end

  # PUT /institucions/1
  # PUT /institucions/1.xml
  def update
    @institucion = Institucion.find(params[:id])

    if @institucion.update_attributes(params[:institucion])
      redirect_to institucions_path
    else
      redirect_to :back
    end
    
  end

  # DELETE /institucions/1
  # DELETE /institucions/1.xml
  def destroy
    @institucion = Institucion.find(params[:id])
    identidad = @institucion.id
    @institucion.destroy

    lista = Usuario.all(:conditions => "institucion_id = "+identidad.to_s)
    lista.each do |elem|
      elem.update_attribute("institucion_id",nil)
    end
    @tags = Tag.all(:conditions => "institucion_id = "+params[:id].to_s)
    @tags.each do |item|
      code = item.codigo
      listax = Evaluacion.all(:conditions => "tag_codigo = '"+code+"'")
      listax.each do |elemx|
        elemx.update_attribute("tag_codigo",nil)
      end
    end

    respond_to do |format|
      format.html { redirect_to(institucions_url) }
      format.xml  { head :ok }
    end
  end
end
