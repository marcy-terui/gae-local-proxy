f = ENV['APP_DIR'] + '/app.yaml'
s = YAML.load(IO.read(f))
u = Userdata.new 'handlers_key'
u.handlers = s['handlers']
