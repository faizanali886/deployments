#!/bin/bash

# Deploy to EC2 instance

# Ensure that secrets are provided as environment variables
if [[ -z "${SSH_HOST}" || -z "${SSH_PRIVATE_KEY}" ]]; then
  echo "Error: Missing required environment variables (SSH_HOST, SSH_PRIVATE_KEY)."
  exit 1
fi

# Variables from secrets
SSH_KEY_PATH=~/.ssh/id_rsa
SSH_HOST=$SSH_HOST

# Debugging: Print environment variables for verification (exclude private key)
echo "Deploying to EC2 instance with SSH_HOST=$SSH_HOST"

# Set up SSH private key for authentication
echo "$SSH_PRIVATE_KEY" > $SSH_KEY_PATH
chmod 600 $SSH_KEY_PATH

# Verify SSH private key and file permissions
echo "SSH private key set up at $SSH_KEY_PATH"

# Manually set the username to 'ubuntu'
SSH_COMMAND="ssh -o StrictHostKeyChecking=no -i $SSH_KEY_PATH ubuntu@$SSH_HOST \
  'mkdir -p /home/ubuntu && echo \"hello i am test file from deploy.sh of your second account\" >> /home/ubuntu/test_file.txt'"

# Execute the SSH command to deploy
echo "Running deployment on EC2 instance..."
$SSH_COMMAND
