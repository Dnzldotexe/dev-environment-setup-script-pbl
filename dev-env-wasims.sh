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

# Install Tailwind CSS
./vendor/bin/sail npm install -D tailwindcss postcss autoprefixer
./vendor/bin/sail npx tailwindcss init -p

# Install React using Laravel Breeze
./vendor/bin/sail php artisan breeze:install react
./vendor/bin/sail npm install

# Run Sail in the background
./vendor/bin/sail up -d

# Run database migrations
./vendor/bin/sail php artisan migrate

# Compile assets
./vendor/bin/sail npm run dev

# Add an alias
sudo echo "alias sail='./vendor/bin/sail'" >> ~/.bashrc
source ~/.bashrc

# Print some instructions
echo "Sail is already running in the background, open your browser and type localhost"
echo "Use commmand 'sail stop' to stop sail"
echo "Use commmand 'sail down' to stop and remove sail"
echo "Use commmand 'sail up -d' to run sail in the background"
