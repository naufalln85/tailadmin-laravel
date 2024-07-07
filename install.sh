#!/bin/bash

# Install dependencies
npm install

# Compile assets
npm run dev

# Install PHP dependencies
composer install

# Set up environment file
cp .env.example .env

# Generate application key
php artisan key:generate

# Update database host dan port, serta password di .env file
sed -i 's/DB_HOST=127.0.0.1/DB_HOST=laravel/g' .env
sed -i 's/DB_PORT=3306/DB_PORT=3307/g' .env
sed -i 's/DB_PASSWORD=/DB_PASSWORD=Opang123**/g' .env

# Run migrations and seed database
php artisan migrate
php artisan db:seed

# Create storage symbolic link
php artisan storage:link
