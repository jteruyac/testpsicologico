class RasgosController < ApplicationController
  # GET /rasgos
  # GET /rasgos.xml
  def index
    @rasgos = Rasgo.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @rasgos }
    end
  end

  # GET /rasgos/1
  # GET /rasgos/1.xml
  def show
    @rasgo = Rasgo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @rasgo }
    end
  end

  # GET /rasgos/new
  # GET /rasgos/new.xml
  def new
    @rasgo = Rasgo.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @rasgo }
    end
  end

  # GET /rasgos/1/edit
  def edit
    @rasgo = Rasgo.find(params[:id])
  end

  # POST /rasgos
  # POST /rasgos.xml
  def create
    rasgo = Rasgo.new(params[:rasgo])
    prueba_data = session[:prueba_preguntas]
    prueba_data.add_rasgo(rasgo)

    session[:prueba_preguntas] = prueba_data
    redirect_to new_prueba_path

#    @rasgo = Rasgo.new(params[:rasgo])
#
#    respond_to do |format|
#      if @rasgo.save
#        flash[:notice] = 'Rasgo was successfully created.'
#        format.html { redirect_to(@rasgo) }
#        format.xml  { render :xml => @rasgo, :status => :created, :location => @rasgo }
#      else
#        format.html { render :action => "new" }
#        format.xml  { render :xml => @rasgo.errors, :status => :unprocessable_entity }
#      end
#    end
  end

  # PUT /rasgos/1
  # PUT /rasgos/1.xml
  def update
    @rasgo = Rasgo.find(params[:id])

    respond_to do |format|
      if @rasgo.update_attributes(params[:rasgo])
        flash[:notice] = 'Rasgo was successfully updated.'
        format.html { redirect_to(@rasgo) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @rasgo.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /rasgos/1
  # DELETE /rasgos/1.xml
  def destroy
    @rasgo = Rasgo.find(params[:id])
    @rasgo.destroy

    respond_to do |format|
      format.html { redirect_to(rasgos_url) }
      format.xml  { head :ok }
    end
  end
end
