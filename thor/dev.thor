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
      load_json_config_file( project_root )
    end

    private

    def load_json_config_file( path )
      current_path = File.expand_path( File.dirname( path ) )
      say "current path is #{current_path}"
    end
  end
end
