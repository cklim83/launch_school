require "sinatra"
require "sinatra/reloader" if development?
require "tilt/erubis"

before do
  @chapters = File.readlines("data/toc.txt")
end

# Calls the block for each chapter, passing that chapter's number, name, and
# contents.
def each_chapter
  @chapters.each_with_index do |chapter, index|
    chapter_num = index + 1
    text = File.read("data/chp#{chapter_num}.txt")
    yield chapter_num, chapter, text
  end
end

# This method returns an Array of Hashes representing chapters that match the
# specified query. Each Hash contain values for its :name, :number, and
# :paragraphs keys. The value for :paragraphs will be a hash of paragraph indexes
# and that paragraph's text.
def chapters_matching(query)
  results = []
  return results if !query || query.empty?

  each_chapter do |chapter_num, chapter, text|
    matched_paras = {}
    text.split(/\n\n+/).each_with_index do |paragraph, id_num|
      matched_paras[id_num] = paragraph if paragraph.include?(query)
    end
    results << {"chapter_num": chapter_num, "chapter": chapter, "paragraphs": matched_paras } unless matched_paras.empty?
  end

  results  
end

get "/" do
  @title = "The Adventures of Sherlock Holmes" 
  
  erb :home
end

get "/chapters/:number" do
  number = params[:number].to_i
  redirect '/' unless (1..@chapters.size).include? number

  @title = "Chapter #{number}: #{@chapters[number - 1]}"
  @text = File.read("data/chp#{number}.txt")
  
  erb :chapter
end

get "/search" do
  @results = chapters_matching(params[:query])

  erb :search
end

not_found do
  redirect '/'
end

helpers do
  def in_paragraphs(string)
    paragraphs = string.split(/\n\n+/)
    paragraphs.map.with_index { |para, index| "<p id='paragraph#{index}'>#{para}</p>" }.join
  end

  def highlight(text, phrase)
    text.gsub(phrase, "<strong>#{phrase}</strong>")  
  end
end
