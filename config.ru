require 'rubygems'
require 'bundler'
require 'sinatra/base'

Bundler.require

Dir.glob('./{models,helpers,controllers}/*.rb').each { |file| require file }

run ApplicationController
use SessionsController
use PostsController
use CommentsController
