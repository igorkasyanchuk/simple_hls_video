#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__)

require 'rubygems'
require 'hs_transfer'
require 'hs_config'
require 'hs_encoder'
require 'pry'

config = HSConfig::load(ARGV[0])
config.set_source('/home/deployer/video.mp4')
config.set_destination('/home/deployer/kom/public/video')

log = HSConfig::log_setup(config)

log.info('HTTP Streamer started')

hstransfer = HSTransfer::init_and_start_transfer_thread(log, config)

hsencoder = HSEncoder.new(log, config, hstransfer)
hsencoder.start_encoding

hstransfer.stop_transfer_thread