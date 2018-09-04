class AssetHandler < Sinatra::Base

  configure do
    set :root, File.expand_path('../../',__FILE__)
    set :views, settings.root + '/assets'
    enable :coffeescript
    set :jsdir, 'public/javascripts'
    set :cssdir, 'public/css'
    set :cssengine, 'scss'
  end

  get 'public/javascripts/*.js' do
    pass unless settings.coffeescript?
    last_modified File.mtime(settings.root + '/assets/' + settings.jsdir)
    cache_control :public, :must_revalidate
    coffee (settings.jsdir + '/' + params[:splat].first).to_sym
  end

  get 'public/css/*.css' do
    last_modified File.mtime(settings.root + '/assets/' + settings.cssdir)
    cache_control :public, :must_revalidate
    send(settings.cssengine, (settings.cssdir + '/' + params[:splat].first).to_sym)
  end

end
