namespace :config do

  desc "Create shared config directory"
  task :create_shared_config do
    on roles :all do
      if test " [ -d #{fetch(:shared_config_path)} ] "
        info "Shared config path already exists"
      else
        info "Shared config path does not exist, creating"
        execute :mkdir, "-p", fetch(:shared_config_path)
      end
    end
  end

  desc "Upload configs to application that aren't in repo"
  task :upload do
    on roles :all do
      fetch(:linked_files).each do |file|
        target = shared_path.join(file)
        unless test "[ -f #{file} ]"
          upload! file, target
        end
      end
    end
  end

  before "deploy:check:make_linked_dirs", "config:create_shared_config"
  after  "deploy:check:make_linked_dirs", "config:upload"
end
