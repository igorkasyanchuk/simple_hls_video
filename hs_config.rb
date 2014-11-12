#!/usr/bin/env ruby

require 'hs_transfer'

require 'logger'
require 'yaml'

class HSConfig

  def self.load(config_file)
    HSConfig.new(config_file)
  end

  def initialize(config_file)
    @config = YAML::load( File.open(ARGV[0]) )
  end

  def [](index)
    @config[index]
  end

  def set_source(file)
    @config['input_location'] = file
  end

  def set_destination(directory)
    @config['directory'] = directory
  end

  def self.log_setup(config)
    if config['log_type'] == 'FILE'
      log = Logger.new(config['log_file'])
    else
      log = Logger.new(STDOUT)
    end

    case config['log_level']
      when 'DEBUG'
        log.level = Logger::DEBUG
      when 'INFO'
        log.level = Logger::INFO
      when 'WARN'
        log.level = Logger::WARN
      when 'ERROR'
        log.level = Logger::ERROR
      else
        log.level = Logger::DEBUG
    end

    log
  end


end
