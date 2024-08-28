#!/bin/bash

# HOW TO USE:
# 1. You need to have Docker installed
# 2. You need to have a running Linux environment
# 3. Clone this shell script
# 4. Run "chmod u+x dev-env-wasims.sh"
# 5. Run "./dev-env-wasims.sh"

# Update distro to the latest version
sudo apt update && sudo apt full-upgrade -y

# Install Laravel Sail to home directory
cd $HOME
curl -s "https://laravel.build/wasims?with=pgsql,redis,meilisearch,mailpit,selenium" | bash
cd $HOME/wasims/

# Run Sail in the background
./vendor/bin/sail up -d
sleep 15

# Run database migrations
./vendor/bin/sail php artisan migrate

# Install React using Laravel Breeze
./vendor/bin/sail composer require laravel/breeze --dev
./vendor/bin/sail php artisan breeze:install react
./vendor/bin/sail npm install

# Install Tailwind CSS
./vendor/bin/sail npm install -D tailwindcss postcss autoprefixer
./vendor/bin/sail npx tailwindcss init -p

# Compile assets
# ./vendor/bin/sail npm run dev

# Add an alias
sudo echo "alias sail='./vendor/bin/sail'" >> ~/.bashrc
source ~/.bashrc

# Print some instructions
echo ""
echo "Sail is already running in the background, open your browser and type localhost"
echo "'sail stop' to stop sail"
echo "'sail down' to stop and remove sail"
echo "'sail up -d' to run sail in the background"
echo "'sail npm run dev' to compile assets"
