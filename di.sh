docker rm -f firmaexpress-rails-dev-i
docker run --net="host" -v $PWD:/var/www/webapp:rw --name firmaexpress-rails-dev-i -i -t patriciojara/firmaexpress-rails:dev /bin/bash