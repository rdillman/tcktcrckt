class AlertController < ApplicationController
  def show
  end

  def create
    @usr_qry = params[:q]
    @results = Block.next_ct_from_addr(@usr_qry)
    debugger
    respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @results }
    end
  end

  def kill
  end

end
