require 'optparse'

module GemfileLockToGemfile
  class Converter
    class << self
      def convert(content, opts={})
        git_refs = {}
        current_git_ref = nil
        scope = nil
        sources = []
        gems = []

        content.split("\n").each do |line|
          if scope
            if scope == 'GIT'
              if match = line.match(/^  ([^ :]+): (.*)/)
                current_git_ref[match[1]] = match[2]
              elsif match = line.match(/^    ([^ ]+) (.*)/)
                current_git_ref['name'] = match[1]
              elsif line.strip.empty?
                git_refs[current_git_ref['name']] = current_git_ref
                current_git_ref = nil
                scope = nil
              else
                # ignore
              end
            elsif scope == 'GEM'
              if match = line.match(/^  remote: (.*)/)
                sources << match[1]
              elsif line.strip.empty?
                scope = nil
              else
              end
            elsif scope == 'PLATFORMS'
              if line.strip.empty?
                scope = nil
              end
            elsif scope == 'DEPENDENCIES'
              if match = line.match(/^  ([^ !]+)(!?)(?: \((.*)\))?/)
                gems << {
                  'name' => match[1],
                  'git' => match[2].nil?,
                  'version' => match[3]
                }
              elsif line.strip.empty?
                scope = nil
              end
            elsif scope == 'BUNDLED_WITH'
              if line.strip.empty?
                scope = nil
              end
            end
          else
            if line =~ /^GIT/
              scope = 'GIT'
              current_git_ref = {}
            elsif line =~ /^GEM/
              scope = 'GEM'
            elsif line =~ /^DEPENDENCIES/
              scope = 'DEPENDENCIES'
            end
          end
        end

        output = []

        if opts[:source]
          output << "source #{opts[:source].inspect}"
        else
          sources.each do |s|
            output << "source #{s.inspect}"
          end
        end

        output << ""

        gems.each do |g|
          line = nil

          if ref = git_refs[g['name']]
            line = "gem #{g['name'].inspect}, git: #{ref['remote'].inspect}"
            line += ", ref: #{ref['ref'].inspect}" if ref['ref']
          else
            line = "gem #{g['name'].inspect}"
            line += ", #{g['version'].inspect}" if g['version']
            line += ", source: #{opts[:custom_sources][g['name']].inspect}" if opts[:custom_sources][g['name']]
          end

          output << line
        end

        return output.join("\n")
      end
    end
  end
end
