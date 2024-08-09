#!/bin/bash

#following funtion is display usage

usage(){
       echo "Usage : $0 /home/ubuntu/logs/log_file.log"
       exit 1
}

#following if statment  will check log file path is provided or not

if [ $# -ne 1 ]; then
   usage
fi

LOG_FILE=$1

#Check if  the log file exist or not

if [ ! -f "$LOG_FILE" ]; then
   echo "Error: Log file $LOG_FILE does not exist!"
   exit 1
fi

#Varible declaration

ERROR_KEYWORD="ERROR"
CRITICAL_KEYWORD="CRITICAL"
DATE=$(date +"%Y-%m-%d")
SUMMARY_REPORT="Summary_report_$DATE.txt"
ARCHIVE_DIR="Processed_logs"

#Summary report
{
	echo "Date of analysis : $DATE"
	echo "Log file name :$LOG_FILE"
} > "$SUMMARY_REPORT"

#Total lines processed

TOTAL_LINES=$(wc -l < "$LOG_FILE")
echo "Total lines processed: $TOTAL_LINES" >> "$SUMMARY_REPORT"

#Count the number of Error messages

ERROR_COUNT=$(grep -c "$ERROR_KEYWORD" "$LOG_FILE")
echo "Total error count: $ERROR_COUNT" >> "$SUMMARY_REPORT"

#List of Critical events with line numbers
echo "List of critical events with lin numbers:" >> "$SUMMARY_REPORT"
grep -n "$CRITICAL_KEYWORD" "$LOG_FILE" >> "$SUMMARY_REPORT"

#Identify the top 5 most common error massages

declare -A error_messages
while IFS= read -r line; do
    if [[ "$line" == *"$ERROR_KEYWORD"* ]]; then
        message=$(echo "$line" | awk -F"$ERROR_KEYWORD" '{print $2}')
	((error_messages["$message"]++))
    fi
done < "$LOG_FILE"

#Sort and display to 5 Error messges
echo "Top 5 Error messages with their occurrence count:" >> "$SUMMARY_REPORT"
for message in "${!error_messages[@]}"; do
    echo "${error_messages[$message]} $message"
done | sort -rn | head -n 5 >> "$SUMMARY_REPORT"

#Optional: Archive or move processed log files

if [ ! -d "$ARCHIVE_DIR" ]; then 
    mkdir -p "$ARCHIVE_DIR"
fi

mv "$LOG_FILE" "$ARCHIVE_DIR/"

echo "Log file has been moved to $ARCHIVE_DIR.!!"

#Print the summary report
cat "$SUMMARY_REPORT"



