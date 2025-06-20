# 🗣️ Fluent Assist — Multilingual Customer Success Platform

Fluent Assist is a **multilingual customer support application** built with Ruby on Rails. It enables businesses to provide **real-time support** in multiple languages, onboard and manage agents, and offer a fully **customizable chat widget** for their site or Shopify store — all with one-click installation.

---

## 🚀 Features

- 🌍 **Multilingual Live Chat Support**  
  Automatically translate live conversations in real-time using seamless Turbo Stream updates.

- ⚡ **Real-Time Messaging** with Turbo + Action Cable  
  Chat is powered by **Turbo Frame** and **Turbo Stream** combined with **Action Cable** for blazing-fast WebSocket-powered conversations.

- 🎨 **Customizable Chat Widget**  
  Match the widget with your brand — colors, welcome messages, agent avatars, and more.

- 👥 **Agent Onboarding & Management**  
  Invite, onboard, and manage support agents from an intuitive dashboard.

- 🧩 **One-Click Installation**  
  Easy embed on any website or Shopify store.

- 🛒 **Shopify Integration**  
  Natively integrates with Shopify for seamless customer data syncing.

- 💳 **Paddle Subscription Integration**  
  Fully integrated with **Paddle** to manage SaaS billing, trials, and recurring subscriptions globally.

---

## ✅ Why Fluent Assist?

- 🏃‍♂️ **Fast** — Optimized with Hotwire (Turbo + Stimulus) for speed and minimal reloads.  
- 📱 **Responsive** — Works flawlessly on mobile, tablet, and desktop.  
- 🧠 **Easy to Use** — Clean UI for both customers and agents.  
- 📈 **Scalable** — From solo operators to large teams.  
- 💡 **Lightweight** — Minimal JS/CSS overhead, fast load times.

---

## 🐳 Docker Setup

This application ships with a full Docker development and production environment.

### Prerequisites

- Docker
- Docker Compose

### Running in Development

```bash
git clone https://github.com/your-org/fluent-assist.git
cd fluent-assist

cp .env.example .env
docker-compose up --build
