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
mix archive.install hex phx_new --force
# mix help phx.new -- use help instead of --help
cd mazaryn
mix deps.get
mix install
# Postgresql
sudo service postgresql start
# sudo -u postgres -i
sudo -u postgres createuser gitpod
createdb
# Copy config
cp scripts/gp.exs config/dev.exs
mix ecto.setup
# Dev
sudo apt-get install inotify-tools -y
mix phx.server