# db_check

db_check是一个用Crystal语言编写的工具，用来检查数据库的健康状态。

## Installation

安装之前要确保你已经安装了Crystal语言的编译器，在 [Crystal官方文档](https://crystal-lang/docs/) 里可以找到安装方法，但是目前不支持Windows系统。

```bash
git clone https://github.com/gnuos/db_check.git
cd db_check
crystal deps
crystall build --release -s src/db_check.cr

```

## Usage

执行下面的命令查看使用帮助

```bash
./db_check help
```

## Development

目前仅支持 mysql 和 postgresql 数据库的健康检查，crystal-mysql 库里有一个bug，在 lib/mysql/src/mysql/connection.cr 文件中有一个 initial_catalog 变量，应将 `initial_catalog = path[1..-1]` 改为 `initial_catalog = path[0..-1]`。

## Contributing

1. Fork it ( https://github.com/[your-github-name]/db_check/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[db_check]](https://github.com/gnuos) Data - creator, maintainer
