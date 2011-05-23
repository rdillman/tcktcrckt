class ResultsController < ApplicationController
  def show
    @usr_qry = params[:q]
    @results = Block.next_ct_from_addr(@usr_qry)
    respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @results }
    end
    
  end

end
