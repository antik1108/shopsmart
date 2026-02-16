# ShopSmart DevOps Guide

This document is a DevOps-focused handoff for the ShopSmart demo project. It covers architecture, build/run steps, environment variables, and deployment notes for AWS or similar platforms.

## Project Summary
- Purpose: Demo full-stack app for DevOps practice
- Frontend: React + Vite (static build)
- Backend: Node.js + Express (REST API)
- Database: Not implemented in code yet (see requirements below)
- Default health API: GET /api/health

## Repository Layout
- client/: Frontend Vite app
- server/: Backend Express app
- render.yaml: Render deployment config (backend + static frontend)
- Idea.md: Requirements checklist

## Requirements (from Idea.md)
- Use SQLite3 for database storage
- Use Prisma for ORM
- Implement at least one full CRUD REST API
- Deploy backend on Render and frontend on Vercel
- Resolve CORS issues after deployment if needed

Note: The current codebase includes only a health check endpoint and does not yet include database/CRUD functionality.

## Runtime Overview
### Backend
- Entry point: server/src/index.js
- App setup: server/src/app.js
- Middleware: CORS enabled, JSON body parsing enabled
- Routes:
  - GET /api/health -> returns status, message, timestamp
  - GET / -> simple string response

### Frontend
- Entry point: client/src/main.jsx
- Health check fetch in client/src/App.jsx
- Uses VITE_API_URL env var to reach backend base URL

## Local Development
### Prerequisites
- Node.js 18+ recommended
- npm 8+ recommended

### Frontend
- Install: cd client && npm install
- Dev server: npm run dev
- Build: npm run build
- Preview build: npm run preview
- Tests: npm run test

### Backend
- Install: cd server && npm install
- Dev server: npm run dev
- Production: npm start
- Tests: npm test

### Local Environment Variables
Frontend (.env in client/):
- VITE_API_URL=http://localhost:5001

Backend (.env in server/):
- PORT=5001

## Ports
- Backend default: 5001 (overridden by PORT)
- Frontend dev server: Vite default (usually 5173)

## Deployment Notes
### Static Frontend + API Backend
- Frontend is a static Vite build (client/dist)
- Backend is a Node/Express server
- Configure the frontend to point to the backend URL via VITE_API_URL

### Render (existing render.yaml)
- Backend service:
  - build: cd server && npm install
  - start: cd server && npm start
  - env: PORT=10000
- Frontend static site:
  - build: cd client && npm install && npm run build
  - publish: client/dist
  - env: VITE_API_URL from backend service URL

### AWS Options
1) Backend on EC2 or ECS
   - Run Node server on a chosen port
   - Set PORT environment variable
   - Open security group for the port (or 80/443 via reverse proxy)

2) Backend on AWS Elastic Beanstalk
   - Deploy Node app from server/ directory
   - Configure environment variable PORT if needed

3) Frontend on S3 + CloudFront
   - Build client/ and upload client/dist to S3
   - Configure CloudFront for HTTPS
   - Set VITE_API_URL to backend URL at build time

### CORS
- Backend uses cors() with default settings (allows all origins)
- If you lock it down, allow the frontend domain explicitly

## Observability and Logging
- Backend logs to stdout via console.log in server/src/index.js
- No structured logging or tracing yet

## Security Checklist
- Use HTTPS for production
- Set CORS allowlist if exposing publicly
- Avoid committing secrets; use env vars

## Known Gaps
- No database or Prisma setup yet
- No CRUD API implemented yet
- No CI pipeline configured

## Quick Verification
- Backend: GET /api/health returns JSON with status ok
- Frontend: loads page and displays backend status
