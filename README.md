# [ReadView](https://readview.onrender.com)

ReadView is a modern Rails 8 application featuring dynamic content creation, rich user interactions, and a clean, responsive UI using Tailwind CSS + Flowbite. Built with Hotwire (Turbo & Stimulus), it provides a smooth single-page-app feel without the complexity of a full front-end framework.

---

## ✨ Features

### ✅ Core Functionality
- 📄 **User Registration & Authentication** via Devise
- 👤 **User Profiles** with avatars and custom usernames
- 📝 **Post Creation** with:
  - Text
  - Images (multiple uploads)
  - Video uploads
- 💬 **Commenting System**
  - Nested replies (Threaded comments)
  - Real-time updates using Turbo Frames
- ⬆️⬇️ **Post & Comment Reactions**
  - Like/Dislike system
- 👥 **User Following System**
  - Follow/unfollow other users
- 🔍 **Omniauth Login Support**
  - Google and GitHub social login

---

## 🎨 UI/UX
- Built with **Tailwind CSS** and **Flowbite** for a beautiful, accessible interface.
- Fully responsive design.
- Animated transitions on interactions.
- Button, card, and form components styled with consistency across all views.

---

## 🛠️ Tech Stack

### Backend
- Ruby on Rails 7
- PostgreSQL
- Redis (for caching and background job processing)
- Sidekiq (background jobs)

### Frontend
- Hotwire (Turbo, Stimulus)
- Tailwind CSS (via Tailwind Rails)
- Flowbite
- Swiper

### Infrastructure
- Redis
- Postgres
- Puma (web server)

### Deployment
- Render
---

## 📷 Media Support

- Upload **multiple images** per post.
- Upload **one video** per post.
- Image carousel (using SwiperJS).
- Media is handled with ActiveStorage and rendered in responsive containers.

---

## ⚡ Turbo & Turbo Frames

The app leverages **Turbo Frames** and **Turbo Streams** to:
- Update likes/dislikes without page reloads.
- Render new comments inline via frame nesting.
- Load forms dynamically (e.g., replies, editing).

---

## 🔐 Authentication

- Devise handles registration, login, password management.
- Users can optionally upload avatars.
- Social login enabled via **Omniauth** (Google, GitHub).

---
## 🐳 Running the App with Docker
This project is fully Dockerized for easy setup and deployment. Follow the steps below to run the app in containers.
### ⚙️ Prerequisites
- Docker installed
- Docker Compose
### 📁 1. Clone the Repository
```
git clone https://github.com/your-username/your-repo-name.git
cd your-repo-name
```
### 🔐 2. Add Your Environment Variables
Create a .env file in the root directory with the following contents:
```
RAILS_MASTER_KEY=your_master_key_here
```
### 🛠️ 3. Build and Start the App
Run the following command to build and start all services:
```
docker-compose up --build
```
This will:
- Build your Rails app image
- Start:
    - PostgreSQL (db)
    - Redis (redis)
    - Rails server (web)
    - Sidekiq (sidekiq)

The app will be available at:
http://localhost:3000

## 🧪 Running Locally

### 1. Clone the repo
```bash
git clone https://github.com/KangarooAlpha/ReadView
```
2. Install dependencies
```
bundle install
yarn install --check-files
```
3. Setup the database
```
rails db:create db:migrate db:seed
```
4. Run the server
```
bin/dev
```
Visit http://localhost:3000 to explore the app!

## 📦 Dependencies
- Tailwind CSS
- Flowbite
- Devise
- Omniauth Google & GitHub
- Turbo (Hotwire)
- Stimulus
- SwiperJS

## 📌 Todo / Roadmap
 - User Feed (posts from followed users)
 - Notifications (likes/comments/replies)
 - Search functionality
 - Infinite scrolling for posts

## 📄 License
MIT License
