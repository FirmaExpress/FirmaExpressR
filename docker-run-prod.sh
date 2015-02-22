#docker rm -f simplecases-pg-dev
docker rm -f firmaexpress-rails-prod; 
service apache2 stop; service postgresql stop
#rake db:migrate RAILS_ENV=development
#rake db:seed
#docker run -d -p 127.0.0.1:5432:5432 --name simplecases-pg-dev claudevandort/simplecases-pg:dev
docker run -d --net="host" -v $PWD:/var/www/webapp:rw --name firmaexpress-rails-prod patriciojara/firmaexpress-rails:prod
#docker run -d --net="host" -v $PWD:/var/www/webapp:rw --name firmaexpress-rails-cron-prod patriciojara/firmaexpress-rails:prod /bin/bash -l -c "service postfix restart; whenever --update-crontab; cron -f"
#docker run -d --net="host" -v $PWD:/var/www/webapp:rw --name simplecases-rails-prod claudevandort/simplecases-rails:prod /bin/bash -l -c "rake assets:precompile RAILS_ENV=production; whenever --update-crontab"; /usr/sbin/apache2 -D FOREGROUND
#docker run --net="host" -v $PWD:/var/www/webapp:rw --name simplecases-rails-prod-i -i -t claudevandort/simplecases-rails:prod /bin/bash -l
#docker run --name simplecases-pg-dev -i -t claudevandort/simplecases-pg:dev /bin/bash -l
#rake assets:clobber