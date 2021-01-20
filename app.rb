# frozen_string_literal: true

require 'sinatra'
require 'sinatra/reloader'
require './model'
require 'slim'

get '/' do
  redirect to('/memos')
end

get '/memos/new' do
  slim :'/memos/new'
end

get '/memos' do
  # @memos_hash = get_memos(json_file_path)
  @memos = Memo.all
  slim :'/memos/index'
end

post '/memos' do
  Memo.create(
    title: params[:memo_title],
    content: params[:memo_content]
  )
  redirect to('/memos')
end

get '/memos/:id' do
  @memo = Memo.find(params['id'])
  slim :'/memos/show'
end

get '/memos/:id/edit' do
  @memo = Memo.find(params['id'])
  slim :'/memos/edit'
end

enable :method_override

delete '/memos/:id' do
  Memo.delete(params[:id])
  redirect to('/memos')
end

patch '/memos/:id/edit' do
  Memo.update(params[:id],
              title: params[:memo_title],
              content: params[:memo_content])
  redirect to('/memos')
end

not_found do
  'not found'
end
