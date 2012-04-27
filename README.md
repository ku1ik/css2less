# css2less

Turns this

    #foo {
      color: red;
    }
    #foo a {
      color: blue;
    }

Into this

    #foo {
      color: red;
      a {
        color: blue;
      }
    }
    
## Installation

    sudo wget https://raw.github.com/sickill/css2less/master/css2less.rb -O /usr/local/bin/css2less
    sudo chmod a+x /usr/local/bin/css2less

## Usage

    css2less style.css > style.less

## License

MIT

## Author

Marcin Kulik