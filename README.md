# [ReadView](https://readview.app)

A production-ready social media application built with Ruby on Rails, featuring real-time interactions, rich media support, and enterprise-grade AWS infrastructure.

---

## 🏗️ Architecture Overview

ReadView is deployed on **AWS** with a highly available, secure multi-tier architecture:

- **Compute:** ECS (Elastic Container Service) for container orchestration
- **Database:** RDS PostgreSQL with automated backups
- **Cache/Jobs:** ElastiCache Redis for background job processing (Sidekiq)
- **Storage:** S3 for user-uploaded media (images/videos)
- **Networking:** Application Load Balancer across 2 availability zones
- **Security:** Private subnets for application/data layers, public subnets for load balancer
- **CI/CD:** GitHub Actions → ECR → ECS automated deployment pipeline

### Security Architecture
- **Network Segmentation:** Application runs in private subnets, isolated from direct internet access
- **Load Balancer Gateway:** Public-facing ALB forwards traffic to private ECS tasks
- **Security Groups:** Least-privilege access controls between layers
- **Managed Services:** AWS-managed database, cache, and storage with built-in security

---

## ✨ Features

### User Management
- 🔐 **Authentication** via Devise (email/password)
- 🌐 **Social Login** with Google and GitHub (OAuth)
- 👤 **User Profiles** with avatars and custom usernames
- 👥 **Follow System** to build your network

### Content Creation
- 📝 **Rich Posts** with text, multiple images, and video
- 💬 **Nested Comments** with threaded replies
- ⬆️⬇️ **Reactions** (likes/dislikes) on posts and comments
- 📷 **Media Uploads** stored securely on AWS S3

### Real-Time Interactions
- ⚡ **Hotwire (Turbo Streams)** for instant updates without page reloads
- 🔄 **Live Reactions** update immediately across all users
- 💬 **Dynamic Comments** appear inline without refreshing

---

## 🛠️ Tech Stack

### Backend
- **Ruby on Rails** - Web framework
- **PostgreSQL** (AWS RDS) - Relational database
- **Redis** (AWS ElastiCache) - Caching and background jobs
- **Sidekiq** - Asynchronous job processing
- **ActiveStorage** - File upload handling with S3

### Frontend
- **Hotwire** (Turbo + Stimulus) - SPA-like experience without JavaScript frameworks
- **Tailwind CSS** - Utility-first styling
- **Flowbite** - UI component library
- **SwiperJS** - Image carousel

### Infrastructure & DevOps
- **Docker** - Containerization
- **AWS ECS** - Container orchestration
- **AWS ECR** - Container registry
- **AWS S3** - Object storage
- **AWS RDS** - Managed PostgreSQL
- **AWS ElastiCache** - Managed Redis
- **Application Load Balancer** - Traffic distribution
- **GitHub Actions** - CI/CD pipeline

### Authentication
- **Devise** - User authentication
- **OmniAuth** - OAuth integration (Google, GitHub)

---

## 🚀 Deployment

### Production (AWS)

The application is deployed on AWS with a secure, highly available architecture:

**Architecture Flow:**
```
GitHub Push → GitHub Actions CI/CD
    ↓
Docker Image Build → Push to ECR
    ↓
ECS Task Definition Update → Deploy to ECS
    ↓
Load Balancer (Public Subnet) → ECS Tasks (Private Subnet)
    ↓
Application connects to:
    - RDS PostgreSQL (Private Subnet)
    - ElastiCache Redis (Private Subnet)
    - S3 (Media Storage)
```

**High Availability:**
- Multi-AZ deployment across 2 availability zones
- Load Balancer distributes traffic for redundancy
- Managed services (RDS, ElastiCache) with automatic failover

**Security:**
- Application and database in private subnets (no direct internet access)
- Security groups enforce least-privilege access
- Media files stored securely in S3 with presigned URLs

### CI/CD Pipeline

Automated deployment via GitHub Actions:
1. Run tests on push to main branch
2. Build Docker image
3. Push image to AWS ECR
4. Update ECS task definition with new image
5. Deploy to ECS cluster

---

## 💻 Local Development

### Prerequisites
- Ruby 3.x
- Node.js & Yarn
- PostgreSQL
- Redis

### Setup

1. **Clone the repository**
```bash
git clone https://github.com/KangarooAlpha/ReadView.git
cd ReadView
```

2. **Install dependencies**
```bash
bundle install
yarn install
```

3. **Setup database**
```bash
rails db:create db:migrate db:seed
```

4. **Configure environment variables**
Create a `.env` file:
```env
RAILS_MASTER_KEY=your_master_key
DATABASE_URL=postgresql://localhost/readview_development
REDIS_URL=redis://localhost:6379/0
```

5. **Start the server**
```bash
bin/dev
```

Visit `http://localhost:3000`

---

## 🐳 Docker Development

Run the entire stack with Docker Compose:

```bash
# Build and start all services
docker-compose up --build

# Access the app at http://localhost:3000
```

**Services:**
- `web` - Rails application
- `db` - PostgreSQL database
- `redis` - Redis cache/job queue
- `sidekiq` - Background job processor

---

## 🧪 Testing

```bash
# Run test suite
rails test

# Run with coverage
COVERAGE=true rails test
```

---

## 📦 Key Dependencies

- `rails` - Web framework
- `devise` - Authentication
- `omniauth-google-oauth2` - Google OAuth
- `omniauth-github` - GitHub OAuth
- `turbo-rails` - Hotwire Turbo
- `stimulus-rails` - Hotwire Stimulus
- `tailwindcss-rails` - Tailwind CSS
- `sidekiq` - Background jobs
- `aws-sdk-s3` - S3 integration
- `redis` - Caching and job queue

---

## 🗺️ Roadmap

- [ ] User feed (chronological posts from followed users)
- [ ] Real-time notifications
- [ ] Search functionality (users and posts)
- [ ] Trending posts algorithm

---

## 📈 Performance Optimizations

- **Caching:** Redis caching for frequently accessed data
- **Background Jobs:** Email sending and media processing offloaded to Sidekiq
- **CDN:** S3 for efficient media delivery
- **Database Indexing:** Optimized queries for follows, comments, reactions
- **Eager Loading:** N+1 query prevention

---

## 🔒 Security Features

- Secure password storage (bcrypt via Devise)
- OAuth 2.0 for social login
- Private subnet isolation for sensitive resources
- Security group access controls
- Presigned S3 URLs for media access

---

## 📄 License

MIT License

---

## 🙏 Acknowledgments

Built as a learning project to explore:
- Production-grade AWS architecture
- Rails with Hotwire for modern web apps
- Containerized deployment with Docker and ECS
- CI/CD automation with GitHub Actions
