require 'thor'

module Devenv
  class App < Thor
    desc 'init', 'initialize a vagrant/docker build environment'
    method_option :recursive, :type => :boolean, :aliases => [ '-r' ]
    method_option :repo, :type => :string, :default => 'docker-reg.cloud.corp.dig.com:5000', :aliases => [ '-p' ]
    method_option :container_name, :type => :string, :required => true, :aliases => [ '-c' ]
    method_option :tag, :type => :string, :required => false, :default => nil, :aliases => [ '-t' ]
    def init
      puts "Docker build path is #{project_path}"
      puts 'start recusiving' if options[:recursive]
      puts "tag prvided from command line is #{options[:tag]}" if options[:tag]
      puts "docker repository name: #{options[:repo]}" if options[:repo]
      puts "docker container name: #{options[:container_name]}" if options[:container_name]
    end
  end
end
