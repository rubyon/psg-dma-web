class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:login, :get_list, :post_list]

  def get_map
    titles = Title.where(page_id: params[:id])
    digitals = Digital.where(page_id: params[:id])
    analogs = Analog.where(page_id: params[:id])
    gauges = Gauge.where(page_id: params[:id])
    render json: { titles: titles, digitals: digitals, analogs: analogs, gauges: gauges}
  end

  def login
    if request.post?
      params.permit!
      userid = params[:userid]
      password = params[:password]
      render json: { success: true, message: "#{userid} / #{password} 로그인 성공!" }
    end
  end

  def get_list
    if request.post?
      area = params[:area]
      number = params[:number]
      params.permit!
      data = [
        "E28011700000021775AEB117",
        "E28011700000021775AE85E7",
        "E28011700000021775AEB167",
        "E28011700000021775AEB197",
        "E28011700000021775AEB1A7",
        "E28011700000021775AEB147"
      ]

      epc_data = { 'success': true, 'epc': data }

      render json: epc_data
    end
  end

  def post_list
    if request.post?
      epc_data = { 'success': true }
      render json: epc_data
    end
  end
end





