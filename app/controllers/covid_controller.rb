class CovidController < ApplicationController
  def index
  end

  def search
    countries = find_country(params[:country])
    unless countries
      flash[:alert] = 'Country not found'
      return render action: :index
    end
    @country = countries.first
  end

private

  def request_api(url)
    response = Excon.get(
      url,
      headers: {
        "X-RapidAPI-Host" => ENV["RAPIDAPI_API_HOST"],
        "X-RapidAPI-Key" => ENV["RAPIDAPI_API_KEY"]
      }
    )
    return nil if response.status != 200
    JSON.parse(response.body)
  end

  def list_countries
    request_api(
    "https://covid-19-data.p.rapidapi.com/help/countries?format=json"
    )
  end

  def find_country(name)
    request_api(
      "https://covid-19-data.p.rapidapi.com/country?format=json&name=#{(name)}"
    )
  end
end