class WeathersController < ApplicationController
def index
  city = params[:city] || "Santa Cruz"
  state = params[:region] || "CA"

  weathers = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22santacruz%2C%20ca%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
  @forecasts = weathers["query"]["results"]["channel"]["item"]["forecast"]
  @locations = weathers["query"]["results"]["channel"]["item"]["title"]
end

def new
end

def show
end

def create
  @weathers = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{params[:city]}%2C%20#{params[:region]}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
  @forecasts = @weathers["query"]["results"]["channel"]["item"]["forecast"]
  render :index

end
end
