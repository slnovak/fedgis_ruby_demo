require 'sinatra/base'

require 'active_support'
require 'active_support/core_ext'
require 'chain'
require 'compass'
require 'sanitize'
require 'sass'
require 'slim'

class ArcgisLite < Sinatra::Base
  
  set :slim, pretty: true

  get '/search' do
    payload = search params['query']

    slim :results, locals: {
      results: payload.results }
  end

  private

  def search(query)
    arcgis_online.sharing.rest.search(q: query)
  end

  def arcgis_online
    Chain::Url.new('https://www.arcgis.com/', _default_parameters: {f: :json})
  end

end
