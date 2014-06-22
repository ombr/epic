
require ::File.expand_path('../config/environment',  __FILE__)

require 'guard/plugin'

module ::Guard
  class EpicGuard < ::Guard::Plugin
    def run_all
    end

    def run_on_changes(paths)
      paths.each do |path|
        Image.delay.upload path
      end
    end
  end
end

guard :EpicGuard do
  watch(%r{^.*\.[jJ][pP]([eE])*[gG]$})
end
