require "json"

class DbCheck::Database
  property scheme : String
  property host : String
  property port : Int32
  property name : String
  property user : String
  property password : String

  getter url : URI
  setter url : URI

  def initialize
    @scheme = ""
    @host = ""
    @port = 0
    @name = ""
    @user = ""
    @password = ""
    @url = URI.new

    yield self
  end

  def initialize(path : String)
    text = File.read(path)
    parse = JSON.parse(text)

    @scheme = parse.["scheme"].as_s
    @host = parse.["host"].as_s
    @port = parse.["port"].as_i
    @name = parse.["name"].as_s
    @user = parse.["user"].as_s
    @password = parse.["password"].as_s
    @url = URI.new
  end

  def connect(&block)
    @url.scheme = @scheme
    @url.host = @host
    @url.port = @port
    @url.path = @name
    @url.user = @user
    @url.password = @password

    DB.connect(@url, &block)
  end
end
