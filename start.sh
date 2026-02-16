#!/bin/bash

echo "Starting backend..."
cd server
npm install
npm run dev &

echo "Starting frontend..."
cd ../client
npm install
npm run dev
