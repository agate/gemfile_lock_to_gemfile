# Gemfile Lock To Gemfile

> A tool for reversing `Gemfile.lock` -> `Gemfile`

## Why I have to develop this tool

One of my ruby project is using bundler to manage gem dependencies. But the `Gemfile` is very complicate. It requires external `Gemfile` by using ruby `eval`. Because I have lots of similar projects that will use same piece of gems. So I decide to abstract these gems into a standalone `Gemfile`. And let those projects’ `Gemfile` loads it.

The problem I met is when I building my docker image. I hope that image can pre-install all the ruby gems in that `Gemfile.lock`. Unluckily, `bundle install` require you must have the `Gemfile`. So I have to find out a way to revert `Gemfile.lock` to a usable `Gemfile`.

So here we are!

