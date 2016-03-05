#!/usr/bin/env ruby
$LOAD_PATH << './lib'
require 'optparse'
require 'uri'
require 'net/http'
require 'helper'
include Helper

def wget_download(url)
  if ! wget_installed?
    puts "wget not installed or not in path"
    exit 1
  end
  #Check if url is valid
  puts url
  if valid_url?(url)
    url = URI.parse(url)
  else
    puts "Not a valid URL. Exiting"
    exit 0
  end

  wget_opts = '-p --convert-links --recursive -l 1'
  # -p              parent directories included
  # --convert-links lookup all links included on the page exclusive external links
  # --recursive     include all content of the desired website
  # -l              maximum level of depth in context of recursive

  %x{wget #{wget_opts} #{url}}
end

if ARGV.empty? or ARGV.first !~ /^-/
  ARGV << '-h'
end

def put_to_artifactory
  # Routine to put content to Artifactory
end

options = {}
OptionParser.new do |opts|
  opts.banner = "Supertool to download stuff and put on Artifactory"
  
  opts.on("-w", "--weburl=URL", "a valid URL in form of http://foobar.com/baz") { |u| options[:weburl] = u }
  opts.on("-a", "--artifactory", "a valid URL and path to Artifactory") { |a| options[:artifact] = a }
  opts.on("-h", "--help", "Show this message") do
    puts opts
    exit 0
  end
end.parse!

wget_download(options[:weburl])
