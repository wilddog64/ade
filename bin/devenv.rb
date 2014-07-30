#!/usr/bin/env ruby

require 'Devenv/runner'

Devenv::Runner.new( ARGV.dup ).execute!
