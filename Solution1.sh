#!/bin/bash
# Checking if exactly one argument is provided at the time of executing script
if [ "$#" -ne 1 ]; then
    echo "Usage of the script: $0 log file/Path to log file"
    exit 1
fi

log_file="$1"

# Checking if the log file exists and is readable
if [ ! -r "$log_file" ]; then
    echo "Error: Log file does not exist or is not readable."
    exit 1
fi

# Total Requests Count

total_requests=$(wc -l < "$log_file")
echo "Total Requests Count: $total_requests"

# Percentage of Successful Requests with HTTP status codes 200-299

success_req=$(grep -E 'HTTP/1\.[01]" 2[0-9]{2}' "$log_file" | wc -l)
success_percents=$(awk -v total="$total_requests" -v success="$success_req" 'BEGIN { if (total > 0) printf "%.2f", (success / total) * 100; else print "0.00" }')
echo "Percentage of Successful Requests: $success_percents%"

# Most Active User (IP address with the most requests)

most_active_user=$(awk '{print $1}' "$log_file" | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')
echo "Most Active User: $most_active_user"

exit 0
