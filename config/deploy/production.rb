set :stage, :production
set :deploy_to, '~/sites/mageskel'

# Simple Role Syntax
# ==================
# Supports bulk-adding hosts to roles, the primary
# server in each group is considered to be the first
# unless any hosts have the primary property set.
role :app, %w{deploy@dev.wearejh.com}
role :web, %w{deploy@dev.wearejh.com}
role :db,  %w{deploy@dev.wearejh.com}

set :baseUrl, 'http:/mageskel.wearejh.com/'