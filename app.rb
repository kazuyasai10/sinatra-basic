# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require './model'
require 'slim'

json_file_path = 'data.json'

get '/' do
  redirect to('/memos')
end

get '/memos/new' do
  slim :'/memos/new'
end

get '/memos' do
  @memos_hash = get_memos(json_file_path)
  p 'test'
  slim :'/memos/index'
end

post '/memos' do
  insert_data_to_json(json_file_path, params[:memo_title], params[:memo_content])
  redirect to('/memos')
end

get '/memos/:id' do
  @memo_hash = get_memo_from_id(json_file_path, params['id'])
  slim :'/memos/show'
end

get '/memos/:id/edit' do
  @memo_hash = get_memo_from_id(json_file_path, params[:id])
  slim :'/memos/edit'
end

enable :method_override

delete '/memos/:id' do
  delete_memo_from_id(json_file_path, params[:id])
  redirect to('/memos')
end

patch '/memos/:id/edit' do
  update_memo_from_id(json_file_path, params[:id], params[:memo_title], params[:memo_content])
  redirect to('/memos')
end

not_found do
  'not found'
end
