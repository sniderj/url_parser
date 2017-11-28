class UrlParser
  attr_accessor :link 
  def initialize(link)
    @link = link
    @url = @link.split("://")
  end #end def initialize

  def scheme  #get scheme attribute ("http")
    scheme = @url[0]
  end #end def scheme

  def domain 
      if @url[1].include?(":") then
          domain = @url[1].split(":")[0] 
      elsif @url[1].include?("/") then 
          domain = @url[1].split("/")[0]
      end
  end #end def domain

  def port 
      if @url[1].include?(":")  #if url contains : then do split at :
          port = @url[1].split(":")[1].split("/")[0] 
      elsif @url[0] == "http" then 
          port = "80"
      elsif @url[0] == "https" then 
          port = "443"  
      end 
  end #end def port

  def path
       # if the url after :// split contains / 
      if @url[1].include?("/") then 
          # check if url after :// split contains ?
          if @url[1].include? "?" 
              path = @url[1].split("/")[1].split("?")[0]
          # check if url after :// contains #
          elsif @url[1].include? "#"
              path = @url[1].split("/")[1].split("#")[0]
          # else return path
          else
              path = @url[1].split("/")[1]
          end
      end
      # if path is equal to blank ("") then return nil
      path == "" ? nil : path

  end #end def path

  def fragment_id
      if @link.include?("#") then
          fragment_id = @link.split("#")[1]
      end
  end #end def fragment_id

  def query_string
      query = {}
      if @link.include? "?" 
          if @link.include? "#"
              querystring = @link.split("?")[1].split("#")[0]
          else
              querystring = @link.split("?")[1]
          end
          #check if url has multiple parameters
          if querystring.include? "&"
            #seperate parameters by &
              querystring.split("&").each do |parameter|
                  #hashmap key is equal to parameter value.  Hashmap value is equal to parameter value
                  key = parameter.split("=")[0]
                  value = parameter.split("=")[1]
                  query[key] = value
              end    
          else
              key = querystring.split("=")[0]
              value = querystring.split("=")[1]
              query[key] = value
          end
      end
      #return query 
      query
  end #end def query string   

end #end class

@url = UrlParser.new("http://www.google.com:60/search?q=cat&name=Tim#img=FunnyCat")

p "scheme answer:"
p @url.scheme
p "domain answer:"
p @url.domain
p "port answer:"
p @url.port
p "path answer:"
p @url.path
p "fragment_id answer:"
p @url.fragment_id
p "query_string answer:"
p @url.query_string

p "No Path Test"
@new_url = UrlParser.new "https://www.google.com/?q=cat#img=FunnyCat"
p @new_url.path
p "No Path Query String Test:"
p @new_url.query_string
p "No Path Fragment id Test:"
p @new_url.fragment_id


p "Insecure URL test:"
insecure_url = UrlParser.new "http://www.google.com/search"
p insecure_url.port

p "Secure URL test:"
secure_url = UrlParser.new "https://www.google.com/search"
p secure_url.port

p "Duplicate Parameters test:"
duplicate_param = UrlParser.new "http://www.google.com:60/search?q=cat&q=overwrite#img=FunnyCat"
p duplicate_param.query_string

