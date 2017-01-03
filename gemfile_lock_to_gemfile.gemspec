# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name         = "gemfile_lock_to_gemfile"
  s.version      = "0.1.0"
  s.date         = Time.now.strftime('%Y-%m-%d')
  s.summary      = "A tool for reversing `Gemfile.lock` -> `Gemfile`"
  s.homepage     = "https://github.com/agate/gemfile_lock_to_gemfile"
  s.email        = "agate.hao@gmail.com"
  s.authors      = [ "agate" ]
  s.has_rdoc     = false

  s.files        = %w( README.md Rakefile LICENSE )
  s.files       += Dir.glob("lib/**/*")
  s.files       += Dir.glob("bin/**/*")
  s.files       += Dir.glob("man/**/*")
  s.files       += Dir.glob("test/**/*")

  s.executables  = %w( gemfile_lock_to_gemfile )
  s.description  = <<END
## Why I have to develop this tool

One of my ruby project is using bundler to manage gem dependencies. But the `Gemfile` is very complicate. It requires external `Gemfile` by using ruby `eval`. Because I have lots of similar projects that will use same piece of gems. So I decide to abstract these gems into a standalone `Gemfile`. And let those projects’ `Gemfile` loads it.

The problem I met is when I building my docker image. I hope that image can pre-install all the ruby gems in that `Gemfile.lock`. Unluckily, `bundle install` require you must have the `Gemfile`. So I have to find out a way to revert `Gemfile.lock` to a usable `Gemfile`.

So here we are!
END
end
