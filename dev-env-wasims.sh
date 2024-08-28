#!/bin/bash

# HOW TO USE:
# 1. You need to have Docker installed
# 2. You need to have a running Linux environment
# 3. Clone this shell script
# 4. Run "chmod u+x dev-env-wasims.sh"
# 5. Run "sudo ./dev-env-wasims.sh"

# Update distro to the latest version
sudo apt update && sudo apt full-upgrade -y

# Install Laravel Sail to home directory
cd ~
curl -s "https://laravel.build/wasims?with=pgsql,redis,meilisearch,mailpit,selenium" | bash
alias sail='sh $([ -f sail ] && echo sail || echo vendor/bin/sail)'
cd ~/wasims/

# Install Tailwind CSS
sail npm install -D tailwindcss postcss autoprefixer
sail npx tailwindcss init -p

# Install React using Laravel Breeze
sail php artisan breeze:install react
sail npm install

# Run Sail in the background
sail up -d

# Run database migrations
sail php artisan migrate

# Compile assets
npm run dev
