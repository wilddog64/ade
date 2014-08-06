module Devenv
  class Vagrant < Thor::Group
    include Thor::Actions

    argument :project_root, :type => :string, :default => '.'
    class_option :vagrant_mount_file, :type => :string, :aliases => [ '-V' ], :default => 'config.json'
    class_option :output_file, :type => :string, :aliases => [ '-o' ], :default => 'Vagrantfile'
    def self.source_root
      File.join( File.dirname(__FILE__), '..','lib', 'templates' )
    end

    def create_vagrant_file
      config = load_json_config_file( project_root, options[:vagrant_mount_file] )
      template(
        'Vagrantfile.erb',
        options[:output_file],
        {
          :mounts          => config['mounts'],
          :vagrant_plugins => config['vagrant_plugins'],
        }
      )
    end

    private

    def load_json_config_file( path, json_file )
      require 'json'
      current_path = File.expand_path( File.dirname( path ) )

      json_file_path = File.join( current_path, json_file )
      say "json file is #{json_file_path}", :yellow
      JSON.parse( IO.read( json_file_path ) )
    end
  end
end
