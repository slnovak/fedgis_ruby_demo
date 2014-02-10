require 'sinatra/base'

require 'active_support/all'
require 'chain'
require 'compass'
require 'dotenv'
require 'hashie'
require 'omniauth-arcgis'
require 'plissken'
require 'sanitize'
require 'sass'
require 'slim'

Dotenv.load

class ArcgisLite < Sinatra::Base
  use Rack::Session::Pool

  use OmniAuth::Builder do
    provider :arcgis, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
  end

  get '/search' do
    slim :items, locals: { items: search }
  end

  get '/items' do
    slim :items, locals: { items: current_user_items }
  end

  get '/auth/:provider/callback' do
    session[:auth_payload] = Hashie::Mash.new(request.env['omniauth.auth'].to_snake_keys)
    redirect "/items"
  end

  private

  def arcgis_online
    @arcgis_online ||= Chain::Url.new('https://www.arcgis.com/', _default_parameters: { f: :json, token: token })
  end

  def search
    params[:query] ||= 'crime'
    results = arcgis_online.sharing.rest.search(q: "#{params[:query]} AND type=\"feature service\"")
    snake_casify results.results
  end

  def current_user_items
    user_info = arcgis_online.sharing.rest.content.users[current_user.username]._fetch
    items = user_info.items.select{|item| item.typeKeywords.include? "Feature Service"}
    snake_casify items
  end

  def auth_payload
    session[:auth_payload]
  end

  def current_user
    @current_user ||= auth_payload.info if auth_payload
  end

  def token
    @credentials ||= auth_payload.credentials.token if auth_payload
  end

  def snake_casify(items)
    items.map(&:to_snake_keys).map{|x| Hashie::Mash.new x}
  end

end
