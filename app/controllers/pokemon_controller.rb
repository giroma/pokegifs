class PokemonController < ApplicationController
  def index
    render json: {'message': 'ok'}
  end
  def show
    res = HTTParty.get("http://pokeapi.co/api/v2/pokemon/#{params[:id]}/")
    poke_body = JSON.parse(res.body)
    id = poke_body['id']
    name  = poke_body["name"]
    type  = poke_body["types"][0]['type']['name']

    res = HTTParty.get("https://api.giphy.com/v1/gifs/search?api_key=#{ENV["GIPHY_KEY"]}&q=#{name}")
    gif_body = JSON.parse(res.body)
    gif_url = gif_body["data"][0]["url"]

    render json: { 'id' => "#{id}", 'name' => "#{name}", 'type' => "#{type}", 'gif' => "#{gif_url}"}

  end
end
