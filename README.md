# Bower Server

Full Sinatra App. I added support for http repos. I'm using this w apache & passenger.

## Create package

    curl http://mycompany/packages -v -F 'name=jquery' -F 'url=git://github.com/jquery/jquery.git'

## Find package

    curl http://mycompany/packages/jquery
      {"name":"jquery","url":"git://github.com/jquery/jquery.git"}

## License

Copyright 2012 Twitter, Inc.

Licensed under the MIT License
