# Step 1: Base Image
# Every Dockerfile starts with a base image. We're using official Node.js (Alpine is a very small, lightweight Linux version)
FROM node:18-alpine

# Step 2: Working Directory
# This tells Docker to create and use the /app folder inside the container for our upcoming commands
WORKDIR /app

# Step 3: Copy Dependencies Files First
# We copy package.json (and package-lock.json if it exists) to the container.
# Why first? Docker caches these layers! If dependencies don't change, Docker skips re-installing them next build.
COPY server/package*.json ./

# Step 4: Install Dependencies
# Runs inside the container to install the packages defined in your package.json
RUN npm install

# Step 5: Copy Source Code
# Now we copy the rest of your server code into the container's /app directory
COPY server/ ./

# Step 6: Expose Port
# Your Express server in `src/index.js` listens on port 5001. This instruction is mostly documentation
# telling Docker that the container will listen on this port at runtime.
EXPOSE 5001

# Step 7: Starting Command
# This sets the default command that runs when the container starts.
CMD ["npm", "start"]



