class ApiController < ApplicationController
  def get_map
    titles = Title.where(page_id: params[:id])
    digitals = Digital.where(page_id: params[:id])
    analogs = Analog.where(page_id: params[:id])
    gauges = Gauge.where(page_id: params[:id])
    render json: { titles: titles, digitals: digitals, analogs: analogs, gauges: gauges}
  end
end
