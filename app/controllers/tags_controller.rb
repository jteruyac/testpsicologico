class TagsController < ApplicationController
  include ApplicationHelper
  # GET /tags
  # GET /tags.xml
  def index
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      if params[:institucion]
        session[:time] = Time.now
        @institucion = Institucion.find(params[:institucion])
        @tags = Tag.find_all_by_institucion_id(params[:institucion], :include => :institucion)

        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @tags }
        end
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /tags/1
  # GET /tags/1.xml
  def show
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @tag = Tag.find(params[:id])
      session[:time] = Time.now
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @tag }
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /tags/new
  # GET /tags/new.xml
  def new
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      if params[:institucion]
          session[:time] = Time.now
          @tag = Tag.new
          @institucions = Institucion.all
          @tag.institucion_id = params[:institucion]

          respond_to do |format|
            format.html # new.html.erb
            format.xml  { render :xml => @tag }
          end
      end
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # GET /tags/1/edit
  def edit
    check_timeout
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @tag = Tag.find(params[:id])
      @institucions = Institucion.all
      session[:time] = Time.now
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  # POST /tags
  # POST /tags.xml
  def create
    @tag = Tag.new(params[:tag])
    @tags = Tag.find_all_by_institucion_id(@tag.institucion_id, :include => :institucion)
    repetido_n = false
    @tags.each do |uno|
      if @tag.nombre == uno.nombre
        repetido_n = true
      end
    end
    repetido_c = false
    @tags.each do |dos|
      if @tag.codigo == dos.codigo
        repetido_c = true
      end
    end
    if !repetido_n
      if !repetido_c
        if @tag.save
          flash[:notice] = 'Tag creado correctamente'
          redirect_to :controller => :tags, :action => :index, :institucion => @tag.institucion_id
        else
          flash[:notice] = 'Error 0'
          redirect_to :controller => :tags, :action => :new, :institucion => @tag.institucion_id
        end
      else
        flash[:notice] = 'Error 10'
        redirect_to :controller => :tags, :action => :new, :institucion => @tag.institucion_id
      end
    else
      flash[:notice] = 'Error 5'
      redirect_to :controller => :tags, :action => :new, :institucion => @tag.institucion_id
    end
  end

  # PUT /tags/1
  # PUT /tags/1.xml
  def update
    @tag = Tag.find(params[:id])

    respond_to do |format|
      if @tag.update_attributes(params[:tag])
        flash[:notice] = 'Tag was successfully updated.'
        format.html { redirect_to :controller => :tags, :action => :index, :institucion => @tag.institucion_id }
        
      else
        @institucions = Institucion.all
        format.html { render :action => "edit" }
        format.xml  { render :xml => @tag.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tags/1
  # DELETE /tags/1.xml
  def destroy
    @tag = Tag.find(params[:id])
    identidad_i = @tag.institucion_id
    identidad_t = @tag.codigo
    @tag.destroy

    lista = Evaluacion.all(:conditions => "tag_codigo = '"+identidad_t.to_s+"'")
    lista.each do |elem|
      elem.update_attribute("tag_codigo",nil)
    end

    respond_to do |format|
      format.html { redirect_to :controller => :tags, :action => :index, :institucion => identidad_i }
      format.xml  { head :ok }
    end
  end
end
