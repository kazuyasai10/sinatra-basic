# frozen_string_literal: true

require 'json'
require 'securerandom'
require 'pg'

class Memo
  JSON_FILE_PATH = 'data.json'
  CONNECTION = PG::Connection.new(dbname: 'memo')

  attr_reader :id, :title, :content

  def initialize(id: '000', title: 'notitle', content: 'no-content')
    @id = id
    @title = title
    @content = content
  end

  def self.find(id)
    memos = []
    memo_tables = CONNECTION.exec("SELECT * FROM memo_table WHERE id= '#{id}';")
    memo_tables.each do |memo|
      memos << memo
    end
    memos[0]
    Memo.new(id: memos[0]['id'], title: memos[0]['title'], content: memos[0]['content'])
  end

  def self.all
    memos = []
    memo_tables = CONNECTION.exec('SELECT * FROM memo_table;')
    memo_tables.each do |memo|
      memos << Memo.new(id: memo['id'], title: memo['title'], content: memo['content'])
    end
    memos
  end

  def self.create(title: '', content: '')
    id = SecureRandom.uuid
    CONNECTION.exec("INSERT INTO memo_table VALUES('#{id}', '#{title}', '#{content}')")
  end

  def self.update(id, title: '', content: '')
    query = "UPDATE memo_table 
    SET title = '#{title}',
    content = '#{content}'
    WHERE id = '#{id}'"
    CONNECTION.exec(query)
  end

  def self.delete(id)
    CONNECTION.exec("DELETE FROM memo_table WHERE id = '#{id}'")
  end
end
