($LOAD_PATH << File.expand_path("../lib", __FILE__)).uniq!

require 'gemfile_lock_to_gemfile'

namespace :readme do
  task :generate do
    content = <<END
# #{GemfileLockToGemfile::SPEC.name.split("_").map(&:capitalize).join(' ')}

> #{GemfileLockToGemfile::SPEC.summary}

#{GemfileLockToGemfile::SPEC.description}
END
    File.write(File.expand_path('../README.md', __FILE__), content)
  end
end
