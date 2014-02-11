set :application,       'mage_skel_app'
set :keep_releases,     3

#git details
set :scm, :git
set :repo_url,      'git@bitbucket.org:jhhello/magento-skeleton.git'
set :deploy_via,    :remote_cache
set :branch,        'master'


set :linked_dirs, %w{htdocs/sitemaps htdocs/media htdocs/var vendor}


# set :log_level, :debug
# set :pty, true

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
      # execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  task :symlink_localxml do
    on roles(:app) do |host|
        within release_path do

        if test("[ -e #{release_path}/htdocs/app/etc/local.xml ]")
        else
            execute "ln -s #{shared_path}/local.xml #{release_path}/htdocs/app/etc/local.xml"
        end
      end
    end
  end

  before    'deploy:updated',           'composer:install_no_dev'
  after     'composer:install_no_dev',  'magento:deploy_core'
  after     'magento:deploy_core',      'magento:deploy_modules'

  after :finishing, 'deploy:symlink_localxml'
  after :finishing, 'deploy:cleanup'
end

#After installing magento:install task, configure magento and enable template symlinks
after 'magento:install', 'magerun:install_magento'
after 'magento:install', 'magerun:enable_symlinks'
