class CovidController < ApplicationController
  before_action :index_countries

  def search
    countries = find_country()
    @country = countries&.first
  end

private
  def index_countries
    all_countries = list_countries
    @countries = all_countries.collect { |country| country["name"] }
  end

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

  def find_country()
    request_api(
      "https://covid-19-data.p.rapidapi.com/country?format=json&name=#{URI.encode(params[:country])}"
    )
  end
end