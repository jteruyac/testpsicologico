class MainController < ApplicationController

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

  def autenticar
    @user = params[:datos]
    if ((session["HttpContextId"].nil?) or ((!session["HttpContextId"].nil?) and (session["HttpContextId"] == session[:session_id].hash)))
      if  (valores = Usuario.authenticate(@user['usuario'], @user['password']))
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
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @pruebas = Prueba.find_all_by_publicar(true)
      @evals = Evaluacion.find(:all, :joins => [:prueba], :conditions => 'evaluacions.usuario_id = '+session["usuario"].id.to_s )
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado"
      redirect_to :controller => :main, :action => :login
    end
  end

  def tablero
    if ((session["HttpContextId"]) and (session["HttpContextId"] == session[:session_id].hash))
      @pruebas = Prueba.find_all_by_publicar(true)
    else
      session["usuario"] = nil
      session["HttpContextId"] = nil
      flash[:notice] = "Acceso no autorizado"
      redirect_to :controller => :main, :action => :login
    end
  end

end
