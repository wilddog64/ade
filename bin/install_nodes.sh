#!/usr/bin/env bash


# TODO: loop through the ../nodes directory
# for each script in the directory, create a docker node and run the script content on boot
# if the script is a chef_*.json file, then configure a docker node via chef cookbooks.
# Example chef_disneyidui.json:
# {
#     "repo": "git://github.disney.com:DisneyID/DisneyID_UI_Chef.git",
#     "env": "https://github.disney.com/DisneyID/DisneyID_UI_Chef/raw/master/environments/did-qa/UI-Desktop.json"
# }