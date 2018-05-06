require "./db_check/*"
require "commander"
require "db"
require "mysql"
require "pg"

module DbCheck
  def self.run
    cli = Commander::Command.new do |cmd|
      cmd.use = "db_check"
      cmd.long = "a database check tool for connectability."

      cmd.flags.add do |flag|
        flag.name = "config"
        flag.short = "-c"
        flag.long = "--config"
        flag.default = ""
        flag.description = "json config file."
      end

      # database type
      cmd.flags.add do |flag|
        flag.name = "type"
        flag.short = "-t"
        flag.long = "--type"
        flag.default = "mysql"
        flag.description = "database types."
      end

      # database host
      cmd.flags.add do |flag|
        flag.name = "host"
        flag.short = "-H"
        flag.long = "--host"
        flag.default = "localhost:3306"
        flag.description = "database host."
      end

      # database port
      cmd.flags.add do |flag|
        flag.name = "port"
        flag.short = "-P"
        flag.long = "--port"
        flag.default = 0
        flag.description = "database port."
      end

      # database
      cmd.flags.add do |flag|
        flag.name = "database"
        flag.short = "-d"
        flag.long = "--database"
        flag.default = ""
        flag.description = "database name."
      end

      # username
      cmd.flags.add do |flag|
        flag.name = "user"
        flag.short = "-u"
        flag.long = "--user"
        flag.default = ""
        flag.description = "database username."
      end

      # password
      cmd.flags.add do |flag|
        flag.name = "password"
        flag.short = "-w"
        flag.long = "--password"
        flag.default = ""
        flag.description = "database password."
      end

      cmd.run do |options, arguments|
        if !options.string["config"].empty?
          db = DbCheck::Database.new(options.string["config"])

          db.connect do
            puts "database is ok."
          end
        else
          if options.string["type"].empty? || options.string["host"].empty? ||
             options.string["user"].empty? || options.string["password"].empty? ||
             options.string["database"].empty? || options.int["port"] < 1
            puts cmd.help
            exit(1)
          end

          db = DbCheck::Database.new do |database|
            database.scheme = options.string["type"]
            database.host = options.string["host"]
            database.port = options.int["port"].as(Int32)
            database.name = options.string["database"]
            database.user = options.string["user"]
            database.password = options.string["password"]
          end

          db.connect do
            puts "database is alive."
          end
        end
      end
    end

    Commander.run(cli, ARGV)
  end
end

DbCheck.run
