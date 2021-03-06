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

# Solving issues with encoding
Encoding.default_external = Encoding::UTF_8
Encoding.default_internal = Encoding::UTF_8

#
# Create and configure a toto instance
#
toto = Toto::Server.new do 
  set :author,    "Hugo Lima Borges"                        # blog author
  set :title,     "agaelebe blog"                           # site title
  set :root,      "index"                                   # page to load on /
  set :date,      lambda {|now| now.strftime("%d/%m/%Y") }  # date format for articles
  set :markdown,  :smart                                    # use markdown + smart-mode
  set :disqus,    'agaelebe'                                #disqus id, or false
  set :summary,   :max => 150, :delim => /~/                # length of article summary and delimiter
  set :ext,       'txt'                                     # file extension for articles
  set :cache,     28800                                     # cache duration, in seconds
  set :error,     lambda {|code| "<font style='font-size:250%'>Erro #{code} - Sinto muito! :-(</font>"}
  set :date, lambda {|now| now.strftime("%d/%m/%Y") }
end

run toto


