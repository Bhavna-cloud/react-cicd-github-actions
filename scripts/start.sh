#!/bin/bash
echo "Starting the application..."
cd /home/ec2-user/my-app
npm install --production
pm2 restart my-app || pm2 start npm --name "my-app" -- start
echo "Application started!"
