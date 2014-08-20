#!/usr/bin/env bash

# Note: this script will run inside the vagrant instance--NOT on the host OS
# it will be copied into /vagrant/bin/install_nodes.sh and run from that path

# TODO: loop through the ../nodes directory
# for each script in the directory, create a docker node and run the script content on boot
# if the script is a chef_*.json file, then configure a docker node via chef cookbooks.
# Example chef_disneyidui.json:
# {
#     "repo": "git://github.disney.com:DisneyID/DisneyID_UI_Chef.git",
#     "env": "https://github.disney.com/DisneyID/DisneyID_UI_Chef/raw/master/environments/did-qa/UI-Desktop.json"
# }

for f in ../nodes/*.json; do
	name=$(basename ${f%.*})
	echo "Reading config for $name node...";
	json=$(cat $f)

	# if there is a "chef" key, configure this node via chef
	chef=$(echo $json | jq ".chef")
	if [[ "$chef" -ne "null" ]]; then
		echo "found chef config. Fetching..."
		repo=$(echo $chef | jq ".repo")
		envURL=$(echo $chef | jq ".env")
		envConfig=$(curl $envURL | jq ".")
		# download the cookbook
		mkdir -p /tmp/cookbooks/$name
		git clone $repo /tmp/cookbooks/$name

		# TODO: see if there is a metadata.rb file in the root of the $repo clone
		# if not, then look at the "env" json for the "cookbook_versions"
		# and traverse the "cookbooks" directory of the "repo" clone
		# pass each cookbook directory into berkshelf as a cookbook to resolve

		# otherwise, we can just pass the repo directly to berkshelf as the cookbook directory
	fi
	script=$(echo $json | jq ".script")
	if [[ "$script" -ne "null" ]]; then
		echo "found script: "$script
		source $script
		# TODO: pass this script to vagrant to run on the docker node after first boot
	fi
done


echo "node configuration setup finished"