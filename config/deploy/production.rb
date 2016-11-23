set :stage, :production

server "appsweb.aea267.k12.ia.us", user: "deploy", roles: [:app, :web, :db]
