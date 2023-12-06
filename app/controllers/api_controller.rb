class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:login, :get_location, :get_list, :post_list]

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
      userid = params[:USER_ID]
      password = params[:PASSWORD]
      puts userid
      puts password
      render json: { success: true, message: "#{userid} / #{password} 로그인 성공!" }
      # render file: "#{Rails.root}/public/404.html", status: 404, layout: false
    end
  end

  def get_location
    if request.post?
      params.permit!
      loc_code = params[:LOC_CODE]
      puts loc_code
      if loc_code == "ID10002"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002013",
                  "CCODE_DESC": "1수장고",
                  "P_CCODE": "ID10002"
              },
              {
                  "CCODE": "ID10002002",
                  "CCODE_DESC": "2수장고",
                  "P_CCODE": "ID10002"
              }
          ]
      }'
      # 1 수장고
      elsif loc_code == "ID10002013"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002013001",
                  "CCODE_DESC": "1A장",
                  "P_CCODE": "ID10002013"
              },
              {
                  "CCODE": "ID10002013002",
                  "CCODE_DESC": "1B장",
                  "P_CCODE": "ID10002013"
              }
          ]
      }'
      # 2 수장고
      elsif loc_code == "ID10002002"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002002001",
                  "CCODE_DESC": "2A장",
                  "P_CCODE": "ID10002002"
              },
              {
                  "CCODE": "ID10002002002",
                  "CCODE_DESC": "2B장",
                  "P_CCODE": "ID10002002"
              }
          ]
      }'
      # 1 수장고 A장
      elsif loc_code == "ID10002013001"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002013001001",
                  "CCODE_DESC": "1A1장",
                  "P_CCODE": "ID10002013001"
              },
              {
                  "CCODE": "ID10002013001002",
                  "CCODE_DESC": "1A2장",
                  "P_CCODE": "ID10002013001"
              }
          ]
      }'
      # 1 수장고 B장
      elsif loc_code == "ID10002013002"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002013002001",
                  "CCODE_DESC": "1B1장",
                  "P_CCODE": "ID10002013002"
              },
              {
                  "CCODE": "ID10002013002002",
                  "CCODE_DESC": "1B2장",
                  "P_CCODE": "ID10002013002"
              }
          ]
      }'

        # 2 수장고 A장
      elsif loc_code == "ID10002002001"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002002001001",
                  "CCODE_DESC": "2A1장",
                  "P_CCODE": "ID10002002001"
              },
              {
                  "CCODE": "ID10002002001002",
                  "CCODE_DESC": "2A2장",
                  "P_CCODE": "ID10002002001"
              }
          ]
      }'
        # 2 수장고 B장
      elsif loc_code == "ID10002002002"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002002002001",
                  "CCODE_DESC": "2B1장",
                  "P_CCODE": "ID10002002002"
              },
              {
                  "CCODE": "ID10002002002002",
                  "CCODE_DESC": "2B2장",
                  "P_CCODE": "ID10002002002"
              }
          ]
      }'


        # 1 수장고 A장 1장
      elsif loc_code == "ID10002013001001"
        json_data = '{
          "numRows": 0,
          "items": [
          ]
      }'
      #   # 1 수장고 A장 1장
      # elsif loc_code == "ID10002013001001"
      #   json_data = '{
      #     "numRows": 0,
      #     "items": [
      #         {
      #             "CCODE": "ID10002013001001001",
      #             "CCODE_DESC": "1A11장",
      #             "P_CCODE": "ID10002013001001"
      #         },
      #         {
      #             "CCODE": "ID10002013001001002",
      #             "CCODE_DESC": "1A12장",
      #             "P_CCODE": "ID10002013001001"
      #         }
      #     ]
      # }'
        # 1 수장고 A장 2장
      elsif loc_code == "ID10002013001002"
        json_data = '{
          "numRows": 0,
          "items": [
          ]
      }'
      #   # 1 수장고 A장 2장
      # elsif loc_code == "ID10002013001002"
      #   json_data = '{
      #     "numRows": 0,
      #     "items": [
      #         {
      #             "CCODE": "ID10002013001002001",
      #             "CCODE_DESC": "1A21장",
      #             "P_CCODE": "ID10002013001002"
      #         },
      #         {
      #             "CCODE": "ID10002013001002002",
      #             "CCODE_DESC": "1A22장",
      #             "P_CCODE": "ID10002013001002"
      #         }
      #     ]
      # }'
        # 1 수장고 B장 1장
      elsif loc_code == "ID10002013002001"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002013002001001",
                  "CCODE_DESC": "1B11장",
                  "P_CCODE": "ID10002013002001"
              },
              {
                  "CCODE": "ID10002013002001002",
                  "CCODE_DESC": "1B12장",
                  "P_CCODE": "ID10002013002001"
              }
          ]
      }'
        # 1 수장고 B장 2장
      elsif loc_code == "ID10002013002002"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002013002002001",
                  "CCODE_DESC": "1B21장",
                  "P_CCODE": "ID10002013002002"
              },
              {
                  "CCODE": "ID10002013002002002",
                  "CCODE_DESC": "1B22장",
                  "P_CCODE": "ID10002013002002"
              }
          ]
      }'


        # 2 수장고 A장 1장
      elsif loc_code == "ID10002002001001"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002002002001001",
                  "CCODE_DESC": "2A11장",
                  "P_CCODE": "ID10002002001001"
              },
              {
                  "CCODE": "ID10002002002001002",
                  "CCODE_DESC": "2A12장",
                  "P_CCODE": "ID10002002001001"
              }
          ]
      }'
        # 2 수장고 A장 2장
      elsif loc_code == "ID10002002001002"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002002001002001",
                  "CCODE_DESC": "2A21장",
                  "P_CCODE": "ID10002002001002"
              },
              {
                  "CCODE": "ID10002002001002002",
                  "CCODE_DESC": "2A22장",
                  "P_CCODE": "ID10002002001002"
              }
          ]
      }'










        # 2 수장고 B장 1장
      elsif loc_code == "ID10002002002001"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002002002001001",
                  "CCODE_DESC": "2B11장",
                  "P_CCODE": "ID10002002002001"
              },
              {
                  "CCODE": "ID10002002002001002",
                  "CCODE_DESC": "2B12장",
                  "P_CCODE": "ID10002002002001"
              }
          ]
      }'
        # 2 수장고 B장 2장
      elsif loc_code == "ID10002002002002"
        json_data = '{
          "numRows": 2,
          "items": [
              {
                  "CCODE": "ID10002002002002001",
                  "CCODE_DESC": "2B21장",
                  "P_CCODE": "ID10002002002002"
              },
              {
                  "CCODE": "ID10002002002002002",
                  "CCODE_DESC": "2B22장",
                  "P_CCODE": "ID10002002002002"
              }
          ]
      }'




      else
        json_data = '{}'
      end
      render json: json_data
    end
  end



  def get_list
    if request.post?
      params.permit!
      loc_code = params[:LOC_CODE]
      puts loc_code
      json_data = '{
      "numRows": 2,
      "items": [
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100001",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우1",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100002",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100003",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100004",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100005",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100006",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100007",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100008",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100009",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100010",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100011",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100012",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100013",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100014",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100015",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100016",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100017",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100018",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100019",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          },
          {
              "TAG_ID": "08F8CD1902289245A55DE3EBA0100020",
              "LOC_CODE_LABEL": "수장고/(구)1수장고/A장",
              "RELIC_NO": "서울역사-1-0",
              "RELIC_NM": "망우동지BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB",
              "MCJUCNT1": 1,
              "CURRENT_STOCK": 0
          }
        ]
      }'
      render json: json_data
    end
  end

  def post_list
    if request.post?

      params.permit!

      puts params.inspect

      epc_data = { 'success': true }
      render json: epc_data
    end
  end
end





