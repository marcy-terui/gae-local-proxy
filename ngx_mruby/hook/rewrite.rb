u = Userdata.new 'handlers_key'
hs = u.handlers

req = Nginx::Request.new
uri = req.uri

hout = Nginx::Headers_out.new
redirect_to = ""
hs.each do |h|
  cond = "^#{h['url']}"
  if h.key?('static_dir')
    cond = "#{cond}(.*)"
    target = h['static_dir']
  elsif h.key?('script')
    cond = h['url']
    target = h['script']
  elsif h.key?('static_files')
    cond = h['url']
    target = h['static_files']
  end
  cond = "#{cond}$"
  target = "/#{target}"
  md = uri.match(Regexp.new(cond))
  if md
    match = true
    if h.key?('http_headers')
      h['http_headers'].each do |k,v|
        hout[k] = v
      end
    end
    if md.length > 1
      for i in 1..(md.length - 1) do
        target.gsub!("\\#{i}", md[i])
      end
    end
    redirect_to = target
    break
  end
end
unless redirect_to == ""
  Nginx.redirect redirect_to
  Nginx.return Nginx::DECLINED
else
  Nginx.return Nginx::HTTP_NOT_FOUND
end
