# frozen_string_literal: true
require 'rubygems'

module GemfileLockToGemfile
  SPEC = Gem::Specification::load(File.expand_path("../../gemfile_lock_to_gemfile.gemspec", __FILE__))
  VERSION = SPEC.version
end

require 'gemfile_lock_to_gemfile/converter'
