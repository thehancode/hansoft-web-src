#!/bin/bash
set -euo pipefail

# Build the project
npm run build

# Create and switch to a new temporary branch
git checkout -b temp-gh-pages || {
  echo "Failed to create temp branch"
  exit 1
}

# Remove all files except dist directory
git rm -rf . ':!dist' || {
  echo "Failed to remove files"
  exit 1
}

# Restore .gitignore
git checkout HEAD .gitignore || {
  echo "Failed to restore .gitignore"
  exit 1
}

mv dist/* . && mv dist/.* . 2>/dev/null || {
  echo "Failed to move dist contents"
  exit 1
}

# Remove now-empty dist directory
rm -rf dist || {
  echo "Failed to remove dist directory"
  exit 1
}

# Stage all changes
git add . || {
  echo "Failed to stage changes"
  exit 1
}

# Commit changes
git commit -m "Latest build $(date +%Y-%m-%d)" || {
  echo "Failed to commit changes"
  exit 1
}

# Push to gh-pages branch
git push origin temp-gh-pages:gh-pages --force || {
  echo "Failed to push to gh-pages"
  exit 1
}

# Switch back to main branch
git checkout main || {
  echo "Failed to switch back to main"
  exit 1
}

# Delete temporary branch
git branch -D temp-gh-pages || {
  echo "Failed to delete temp branch"
  exit 1
}

echo "Deployment completed successfully"
