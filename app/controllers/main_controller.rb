class MainController < ApplicationController

  def login
    if (session["usuario"])
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
    if  (session["usuario"] = Usuario.authenticate(@user['usuario'], @user['password']))
      @pruebas = Prueba.all
      if (session["usuario"].administrador == true)
        redirect_to :controller => 'main', :action => 'tablero'
      else
        redirect_to :controller => 'main', :action => 'principal'
      end
    else
      flash[:notice] = "Datos incorrectos"
      redirect_to :action => :login
    end
  end

  def principal
    @pruebas = Prueba.find_all_by_publicar(true)
    @evals = Evaluacion.find(:all, :joins => [:prueba], :conditions => 'evaluacions.usuario_id = '+session["usuario"].id.to_s )

  end

  def tablero
    @pruebas = Prueba.find_all_by_publicar(true)

  end

end
