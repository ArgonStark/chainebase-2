#!/bin/bash

# Define colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Step 1: Navigate to the chromium directory
echo -e "${GREEN}Navigating to the chromium directory...${NC}"
cd chromium || { echo -e "${RED}Failed to navigate to the chromium directory. Ensure it exists.${NC}"; exit 1; }

# Step 2: Edit the docker-compose.yaml file
echo -e "${GREEN}Updating docker-compose.yaml file...${NC}"
if [ ! -f docker-compose.yaml ]; then
  echo -e "${RED}docker-compose.yaml file not found in the chromium directory.${NC}"
  exit 1
fi

# Perform changes using sed
sed -i \
  -e 's/3010/4010/g' \
  -e 's/3011/4011/g' \
  -e 's/container_name: chromium/container_name: chromium1/' \
  docker-compose.yaml

if [ $? -eq 0 ]; then
  echo -e "${GREEN}docker-compose.yaml updated successfully!${NC}"
else
  echo -e "${RED}Failed to update docker-compose.yaml.${NC}"
  exit 1
fi

# Step 3: Bring down existing Docker containers
echo -e "${GREEN}Stopping existing Docker containers...${NC}"
docker compose down

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Docker containers stopped successfully.${NC}"
else
  echo -e "${RED}Failed to stop Docker containers.${NC}"
  exit 1
fi

# Step 4: Bring up updated Docker containers
echo -e "${GREEN}Starting updated Docker containers...${NC}"
docker compose up -d

if [ $? -eq 0 ]; then
  echo -e "${GREEN}Docker containers started successfully.${NC}"
else
  echo -e "${RED}Failed to start Docker containers.${NC}"
  exit 1
fi

echo -e "${GREEN}All steps completed successfully!${NC}"
