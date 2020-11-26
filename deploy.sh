git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git checkout main
git pull origin main

git remote set-url --push origin https://rhea-so:$AccessToken@github.com/github.com/rhea-so.github.io.git/

git add .
git commit -m "circle ci"
git push -f origin main

echo "deployed successfully"