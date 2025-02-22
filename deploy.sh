#!/bin/bash

# Deploy to EC2 instance

# Ensure that secrets are provided as environment variables
if [[ -z "${SSH_HOST}" || -z "${SSH_PRIVATE_KEY}" || -z "${USER_NAME}" ]]; then
  echo "Error: Missing required environment variables (SSH_HOST, SSH_PRIVATE_KEY, USER_NAME)."
  exit 1
fi

# Variables from secrets
SSH_KEY_PATH=~/.ssh/id_rsa
SSH_HOST=$SSH_HOST
USER_NAME=$USER_NAME

# Debugging: Print environment variables for verification (exclude private key)
echo "Deploying to EC2 instance with SSH_HOST=$SSH_HOST and USER_NAME=$USER_NAME"

# Set up SSH private key for authentication
echo "Setting up SSH private key..."
echo "$SSH_PRIVATE_KEY" > $SSH_KEY_PATH
chmod 600 $SSH_KEY_PATH

# Verify SSH private key and file permissions
echo "SSH private key set up at $SSH_KEY_PATH"

# Create the SSH command for deployment
SSH_COMMAND="ssh -o StrictHostKeyChecking=no -i $SSH_KEY_PATH $USER_NAME@$SSH_HOST 'echo \"hello i am test file from deploy.sh of your second account\" > ~/test_file.txt'"

# Execute the SSH command to deploy
echo "Running deployment on EC2 instance..."
$SSH_COMMAND
