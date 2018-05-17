#!/usr/bin/env ruby -wKU

# require "pdf-reader"
require 'fileutils'

ROOT = File.join(File.dirname(__FILE__), 'resources')
ENGLISH_CAFE_ROOT = File.join(ROOT, 'English_Cafe')
ESL_POD_ROOT = File.join(ROOT, 'ESLPod')

def extract_number str
  sprintf("%04d", str.gsub(/[a-zA-Z_-]/, '').to_i)
end

def normalize_filename prefix='ESLPod', filename='ESL-POD_00002.mp3', ext='.mp3'
  basename = File.basename(filename, ext)
  number = extract_number(basename)
  "#{prefix}_#{number}#{ext}"
end

def normalize_path prefix='ESLPod', path='./resources/English_Cafe/1-30/ESL-POD_00002.mp3', ext='.mp3'
  dir = File.dirname(path)
  filename = File.basename(path)
  normalized_filename = normalize_filename(prefix, filename, ext)
  if filename != normalized_filename
    return File.join(dir, normalized_filename)
  else
    return nil
  end
end

def move! org, to
  FileUtils.mv(org, to) if to
end

Dir.glob(File.join(ENGLISH_CAFE_ROOT, '**', '*.mp3')) do |file|
  to = normalize_path('English_Cafe', file, '.mp3')
  move! file, to
end

Dir.glob(File.join(ENGLISH_CAFE_ROOT, '**', '*.pdf')) do |file|
  to = normalize_path('English_Cafe', file, '.pdf')
  move! file, to
  # puts file = to || file
  # document = PDF::Reader.new(file).pages
  # document.each do |page|
  #   puts page.text
  # end
  # raise
end

Dir.glob(File.join(ESL_POD_ROOT, '**', '*.mp3')) do |file|
  to = normalize_path('ESLPod', file, '.mp3')
  move! file, to
end

Dir.glob(File.join(ESL_POD_ROOT, '**', '*.pdf')) do |file|
  to = normalize_path('ESLPod', file, '.pdf')
  move! file, to
end
