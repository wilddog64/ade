# NODES

each node (machine instance) that you want to build will be built from a JSON config file in this directory.
For instance, if you need to run a MySQL node on a seperate operating system from your PHP/Apache system, you can create two node config files in this directory: mysql.json and php.json (the names are arbitrary)

A node configuration looks like the following:

```
{
    // if there is a chef section in your node config
    // then chef will be used to create this node
    "chef":{
        // a chef cookbook repo is required
        "repo": "git://github.disney.com:DisneyID/DisneyID_UI_Chef.git",
        // also a raw link to the environment config file is required
        "env": "https://github.disney.com/DisneyID/DisneyID_UI_Chef/raw/master/environments/did-qa/UI-Desktop.json"
    },
    // specific mounts for this node only
    "mounts": [
        {
            // path is the location of the host directory
            "path": "~/src",
            // mount_point is where it will be located on the node
            "mount_point": "/var/www/html"
        }
    ],
    // any ports that should forward from your native OS into the node
    ports:[{
    	// the port inside the VM
        "guest": 80,
        // the port on your native OS that will direct into the box on the guest port
        "host": 8080
        // so with this config, you can access localhost:8080 and it will load :80 on the node
    }],
    // a shell script to add additional config to this node (after chef runs or instead of chef)
    "script":"disneyid_ui.sh"
}
```