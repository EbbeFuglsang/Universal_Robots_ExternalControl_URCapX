# Example: ./check_response.sh "http://example.com/api/endpoint"

# Parameters
url=$1

# Perform a curl request and capture the HTTP status code
http_status=$(curl -s -o /dev/null -w "%{http_code}" "$url")

# Check if the HTTP status code is 200
if [ "$http_status" -eq 200 ]; then
  echo "Response is OK: $http_status"
  exit 0
else
  echo "Response is not OK: $http_status"
  exit 1
fi