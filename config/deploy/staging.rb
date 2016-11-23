set :stage, :staging

server "207.28.160.55", user: "deploy", roles:[:app,:web, :db]
