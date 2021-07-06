## PHPDev

Just a quick and easy way to get PHP up and running on evyerthing that runs Docker.

## Docker Speed run
Let's assume you have an awesome project! Let's wrap a docker container around it to make it platform independent 

```bash
docker run -it -v $PWD:/var/www/html/ -p 8080:80 xantios/phpdev
```

## Cool and now what?
Open your favorite browser and go to: http://localhost:8080

## Nice! How is this setup?

|Service|Config|
|----|----|
|Nginx|vhost.conf in this repo, easy as could be|
|php-fpm|listens on port 9000, feel free to add -p 9000:9000 to the docker command to access it from outside of the container|
|php|CLI has xdebug enabled|
|xdebug|see xdebug.ini|
|[Maple](https://github.com/xantios/Maple)|To run nginx and php-fpm|

## I Want to customize it!
Feel free! if you have any valuable addition please PR!

Clone this repo, do whatever you want to do and run the included build.sh script