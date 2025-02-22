# Manually set the username to 'ubuntu'
SSH_COMMAND="ssh -o StrictHostKeyChecking=no -i $SSH_KEY_PATH ubuntu@$SSH_HOST \
  'mkdir -p /home/ubuntu && echo \"hello i am test file from deploy.sh of your second account\" >> /home/ubuntu/test_file.txt'"

# Execute the SSH command to deploy
echo "Running deployment on EC2 instance..."
$SSH_COMMAND
