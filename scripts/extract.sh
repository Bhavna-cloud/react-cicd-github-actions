#!/bin/bash
echo "Extracting deployment package..."
cd /home/ec2-user/my-app
tar -xzvf deploy_package.tar.gz
echo "Extraction complete!"
