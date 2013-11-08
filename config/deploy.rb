set :application,   'mage_skel_app'
set :keep_releases, 3

#git details
set :scm, :git
set :repo_url,      'git@bitbucket.org:AydinHassan/jh_magento_skeleton.git'
set :branch,        'master'
set :deploy_via,    :remote_cache

# set :log_level, :debug
# set :pty, true


DB_CONFIG = YAML.load_file('config/deploy/db/staging.yaml');
set :dbHost, DB_CONFIG['databse_host']
set :dbUser, DB_CONFIG['databse_user']
set :dbPass, DB_CONFIG['databse_password']
set :dbName, DB_CONFIG['databse_name']


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

  before 'deploy:updated', 'magerun:install_magento'
  after 'magerun:install_magento', 'composer:install_no_dev'
  after :finishing, 'deploy:cleanup'

end
