#!/bin/bash

# Usage: ./wait_for_response.sh <URL> <EXPECTED_RESPONSE> <TIMEOUT>
# Example: ./wait_for_response.sh "http://example.com/api/endpoint" "success" 300

# Parameters
url=$1
expected_response=$2
timeout=$3

# Initialize a variable to store the actual response
response=""

# Get the start time
start_time=$(date +%s)

# Loop until the response contains the expected response or timeout is reached
while [[ "$response" != *"$expected_response"* ]]; do
  # Make the curl request and store the response
  response=$(curl -s "$url")

  # Print the response for debugging (optional)
  echo "Response: $response"

  # Check if the expected response is found
  if [[ "$response" == *"$expected_response"* ]]; then
    echo "Received the expected response: $expected_response"
    exit 0
  fi

  # Check if the timeout has been reached
  current_time=$(date +%s)
  elapsed_time=$((current_time - start_time))

  if [[ $elapsed_time -ge $timeout ]]; then
    echo "Timeout reached after $elapsed_time seconds."
    exit 1
  fi

  # Sleep for a few seconds before trying again (adjust as needed)
  sleep 5
done