class GuardsController < ApplicationController
  def json_index
    charge=Charge.find_by_ref(params[:id])
    @guards=charge.guards
    render json: @guards
  end

end