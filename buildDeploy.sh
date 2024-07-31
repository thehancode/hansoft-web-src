npm run build
git checkout -b temp-gh-pages
git rm -rf .
git checkout HEAD -- dist .gitignore
mv dist/* dist/.* .
rm -rf  dist
git add .
git commit -m "latest build"
git push origin temp-gh-pages:gh-pages --force
git checkout main
git branch -D temp-gh-pages
