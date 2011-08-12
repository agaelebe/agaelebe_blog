require 'bundler'
Bundler.setup

require 'karakuri'
require 'toto'
require 'coderay'
require 'rack/codehighlighter'

# Rack config
use Rack::Static, :urls => ['/css', '/js', '/images', '/favicon.ico'], :root => 'public'
use Rack::CommonLogger

if ENV['RACK_ENV'] == 'development'
  use Rack::ShowExceptions
end

use Rack::Codehighlighter, :coderay, :markdown => true, :element => "pre>code", :pattern => /\A:::(\w+)\s*(\n|&#x000A;)/i, :logging => true

#
# Create and configure a toto instance
#
toto = Toto::Server.new do 
   set :author,    "Hugo Lima Borges"                        # blog author
   set :title,     "agaelebe blog"                           # site title
   set :root,      "index"                                   # page to load on /
   set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
   set :markdown,  :smart                                    # use markdown + smart-mode
   set :disqus,    'kXEokpTKTP9jlWcDb8zYSiMoseOgEuhKzYAPXdJWXj8mriielsiw1DmiTpv8KyHG'      #disqus id, or false
   set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
   set :ext,       'txt'                                     # file extension for articles
   set :cache,      28800                                    # cache duration, in seconds

  set :date, lambda {|now| now.strftime("%d/%m/%Y") }
end

run toto


