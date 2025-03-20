#!/bin/bash

# Check if SLACK_WEBHOOK is set
if [ -z "$SLACK_WEBHOOK" ]; then
  echo "SLACK_WEBHOOK is not set. Skipping notification."
  exit 0
fi

STATUS=$1
BRANCH=$2
COMMIT=$3
REPO=$4
JOB=$5
WORKFLOW=${GITHUB_WORKFLOW:-"Unknown Workflow"}  # Fetch workflow name from GitHub

# Set color and emoji based on status
if [ "$STATUS" == "success" ]; then
  COLOR="#36a64f"
  EMOJI="✅"
elif [ "$STATUS" == "failure" ]; then
  COLOR="#ff0000"
  EMOJI="❌"
else
  COLOR="#ffcc00"
  EMOJI="⚠"
fi

# Send notification to Slack
curl -X POST -H 'Content-type: application/json' --data '{
  "text": "GitHub Actions Notification",
  "attachments": [
    {
      "color": "'"$COLOR"'",
      "blocks": [
        {
          "type": "section",
          "text": {
            "type": "mrkdwn",
            "text": "*Workflow:* '"$WORKFLOW"'\n*Job:* '"$JOB"'\n*Branch:* '"$BRANCH"'\n*Commit:* '"$COMMIT"'\n*Status:* '"$EMOJI"' '"$STATUS"'"
          }
        },
        {
          "type": "context",
          "elements": [
            {
              "type": "mrkdwn",
              "text": "Repository: <https://github.com/'"$REPO"'|'"$REPO"'>"
            }
          ]
        }
      ]
    }
  ]
}' $SLACK_WEBHOOK
