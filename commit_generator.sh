#!/bin/bash

# Number of commits to create
commit_count=100

# Check if inside a git repository
if [ ! -d .git ]; then
  echo "This directory is not a git repository."
  exit 1
fi

# Get the current branch name
current_branch=$(git rev-parse --abbrev-ref HEAD)

# Function to generate a random date within the past 365 days
generate_random_date() {
  echo $(date -d "$((RANDOM % 365 + 1)) days ago" '+%Y-%m-%d %H:%M:%S %z')
}

for i in $(seq 1 $commit_count)
do
  # Create a random file
  filename="file_$i.txt"
  echo "This is commit number $i" > "$filename"

  # Add the file to git
  git add "$filename"

  # Generate a single random date for both author and committer
  random_date=$(generate_random_date)

  # Commit with the random date
  GIT_COMMITTER_DATE="$random_date" git commit -m "Commit number $i" --date "$random_date"

  echo "Created commit number $i with date $random_date"
done

# Push the changes
git push origin "$current_branch"
