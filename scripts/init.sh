#!/bin/sh
cd ..
git clone https://github.com/mazarynxyz/mazaryn-front.git
cd mazaryn-front/
npm install
cd ..
# elixir/pheonix setup
EXTRA_DEPS="inotify-tools"
DEPS="esl-erlang elixir"
wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && sudo dpkg -i erlang-solutions_2.0_all.deb
sudo apt-get update
sudo apt-get install $DEPS $EXTRA_DEPS -y
mix local.hex --force
mix local.rebar --force
mix archive.install hex phx_new --force
# mix help phx.new -- use help instead of --help
cd mazaryn
mix deps.get
# Postgresql
sudo service postgresql start
# sudo -u postgres -i to switch to postgres user
# This is mostly cuz psql and such try to connect with a pswd. Which hasn't been configured. I think. That or password invalid.
sudo -u postgres psql -c "CREATE USER gitpod with SUPERUSER PASSWORD 'gitpod';"
createdb
sudo -u postgres psql -c "ALTER USER postgres with SUPERUSER PASSWORD 'postgres';"

# Dev
mix ecto.setup
mix phx.server