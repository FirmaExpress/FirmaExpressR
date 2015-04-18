#sudo echo "127.0.0.1 webapp.dev" >> /etc/hosts
ln Gemfile docker/rails/development/Gemfile
ln Gemfile.lock docker/rails/development/Gemfile.lock
ln Gemfile docker/rails/production/Gemfile
ln Gemfile.lock docker/rails/production/Gemfile.lock
mkdir docker/rails/production/ssl
ln ../ssl/FirmaExpressR/firmaexpress_com.ca-bundle docker/rails/production/ssl/firmaexpress_com.ca-bundle
ln ../ssl/FirmaExpressR/firmaexpress_com.crt docker/rails/production/ssl/firmaexpress_com.crt
ln ../ssl/FirmaExpressR/myserver.key docker/rails/production/ssl/myserver.key
ln ../ssl/FirmaExpressR/server.csr docker/rails/production/ssl/server.csr
#docker build -t patriciojara/firmaexpress-pg:dev docker/pg
#docker build -t patriciojara/firmaexpress-rails:dev docker/rails/development
docker build -t patriciojara/firmaexpress-rails:prod docker/rails/production
rm docker/rails/development/Gemfile docker/rails/development/Gemfile.lock docker/rails/production/Gemfile docker/rails/production/Gemfile.lock
rm -R docker/rails/production/ssl
#docker run -d -p 127.0.0.1:80:80 --name rails rails
#docker push patriciojara/firmaexpress-pg:dev
#docker push patriciojara/firmaexpress-rails:dev
docker push patriciojara/firmaexpress-rails:prod