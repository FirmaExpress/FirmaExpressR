docker rm -f firmaexpress-pg-dev; docker rm -f firmaexpress-rails-dev; docker rm -f firmaexpress-rails-cmd
service apache2 stop; service postgresql stop
docker run -d -p 127.0.0.1:5432:5432 --name firmaexpress-pg-dev patriciojara/firmaexpress-pg:dev
docker run -d --net="host" -v $PWD:/var/www/webapp:rw --name firmaexpress-rails-cmd patriciojara/firmaexpress-rails:dev /bin/bash -l -c "rake db:migrate RAILS_ENV=development; rake db:seed --trace"; docker attach firmaexpress-rails-cmd
docker run -d --net="host" -v $PWD:/var/www/webapp:rw --name firmaexpress-rails-dev patriciojara/firmaexpress-rails:dev
#docker run -d --net="host" -v $PWD:/var/www/webapp:rw --name firmaexpress-rails-cron-dev patriciojara/simplecases-rails:dev /bin/bash -l -c "service postfix restart; whenever --update-crontab; cron -f"
#docker run --net="host" -v $PWD:/var/www/webapp:rw --name simplecases-rails-dev -i -t claudevandort/simplecases-rails:dev /bin/bash
#docker run --name simplecases-pg-dev -i -t claudevandort/simplecases-pg:dev /bin/bash
#sudo docker run --net="host" -v $PWD:/var/www/webapp:rw --name simplecases-rails-dev-i -i -t claudevandort/simplecases-rails:dev /bin/bash
