# frozen_string_literal: true

require 'json'
require 'securerandom'

# 読み込んで
def load_json(json_file_path)
  json_data = File.open(json_file_path) do |io|
    JSON.parse(io)
  end
end

def save_json(json_file_path, json_data)
  File.open(json_file_path, 'w') do |io|
    JSON.dump(json_data, io)
  end
end

def make_memo_hash(title, content)
  id = SecureRandom.uuid
  { 'id' => id, 'title' => title, 'content' => content }
end

def get_memos(json_file_path)
  memos = load_json(json_file_path)['memos']
end

def get_memo_from_id(json_file_path, id)
  memos = []
  json_data = load_json(json_file_path)
  json_data['memos'].each do |memo|
    memos << memo if memo['id'] == id
  end
  memo = memos[0]
end

def update_memo_from_id(json_file_path, id, title, content)
  json_data = load_json(json_file_path)
  json_data['memos'].each do |memo|
    if memo['id'] == id
      memo['title'] = title
      memo['content'] = content
    end
  end
  save_json(json_file_path, json_data)
end

def delete_memo_from_id(json_file_path, id)
  json_data = load_json(json_file_path)
  json_data['memos'].delete_if do |memo_hash|
    memo_hash['id'] == id
  end
  save_json(json_file_path, json_data)
end

def insert_data_to_json(json_file_path, title, content)
  json_data = load_json(json_file_path)
  json_data['memos'] << make_memo_hash(title, content)
  save_json(json_file_path, json_data)
end
