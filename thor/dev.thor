module Devenv
  class Vagrant < Thor::Group
    include Thor::Actions

    argument :project_root, :type => :string, :default => '.'
    class_option :vagrant_mount_file, :type => :string, :aliases => [ '-V' ], :default => 'mount.json'
    def self.source_root
      File.join( File.dirname(__FILE__), '..', 'lib', 'templates' )
    end

    def read_mount_file

    end

    def create_vagrant_file
      say "project root @ #{project_root}", :yellow
      load_json_config_file( project_root, options[:vagrant_mount_file] )
    end

    private

    def load_json_config_file( path, json_file )
      require 'json'
      current_path = File.expand_path( File.dirname( path ) )
      say "current path is #{current_path}"

      json_file_path = File.join( current_path, json_file )
      say "json file is #{json_file_path}", :yellow
      JSON.parse( IO.read( json_file_path ) )
    end
  end
end
