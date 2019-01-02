set token [mime::initialize -canonical "text/html" string "Hello, World!"]
smtp::sendmessage $token -recipients "faust@gmx.com"
