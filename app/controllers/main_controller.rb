class MainController < ApplicationController
  include ApplicationHelper

  def login
    if ((session["usuario"]) and (session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      if session["usuario"].administrador
        redirect_to :controller => :main, :action => :tablero
      else
        redirect_to :controller => :main, :action => :principal
      end
    end   
  end

  def logout
    reset_session
    redirect_to :action => :login
  end

  def about
  end

  def autenticar
    @user = params[:datos]
    if ((session["HttpContextId"].nil?) or ((!session["HttpContextId"].nil?) and (session["HttpContextId"] == session[:session_id].hash)))
      if  (valores = Usuario.authenticate(@user['usuario'], @user['password']))
        
        session[:time] = Time.now

        valores.crypt_nombre
        session["usuario"] = valores
        #identificador = session["usuario"].id

        @pruebas = Prueba.all
        if (session["usuario"].administrador == true)
          temporal = session[:session_id]
          session["HttpContextId"] = temporal.hash
          redirect_to :controller => 'main', :action => 'tablero'
        else
          temporal = session[:session_id]
          session["HttpContextId"] = temporal.hash
          redirect_to :controller => 'main', :action => 'principal'
        end
      else
        flash[:notice] = "Datos incorrectos"
        redirect_to :action => :login
      end
    else
      flash[:notice] = "Acceso no autorizado"
      session["HttpContextId"] = nil
      session["usuario"] = nil
      redirect_to :action => :login
    end
  end

  def principal
    check_timeout

    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash) and (session["usuario"]))
      @pruebas = Prueba.find_all_by_publicar(true)
      @evals = Evaluacion.find(:all, :joins => [:prueba], :conditions => 'evaluacions.usuario_id = '+session["usuario"].id.to_s )
      session[:time] = Time.now
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

  def tablero
    check_timeout

    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash) and (session["usuario"]))
      @pruebas = Prueba.find_all_by_publicar(true)
      session[:time] = Time.now
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado o tiempo de conección expirado"
      redirect_to :controller => :main, :action => :login
    end
  end

end
