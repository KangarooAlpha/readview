# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



🐳 Running the App with Docker
This project is fully Dockerized for easy setup and deployment. Follow the steps below to run the app in containers.
⚙️ Prerequisites
Docker installed
Docker Compose (v2+ included with Docker Desktop)
📁 1. Clone the Repository
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
🔐 2. Add Your Environment Variables
Create a .env file in the root directory with the following contents:
RAILS_MASTER_KEY=your_master_key_here
💡 If you don’t have a RAILS_MASTER_KEY, you can either:
Ask the project owner for it
Generate one yourself using rails credentials:edit (only if you're not using the existing credentials.yml.enc)
🛠️ 3. Build and Start the App
Run the following command to build and start all services:
docker-compose up --build
This will:
Build your Rails app image
Start:
PostgreSQL (db)
Redis (redis)
Rails server (web)
Sidekiq (sidekiq)
The app will be available at:
http://localhost:3000