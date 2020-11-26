git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git checkout main
git pull origin main

git remote set-url --push origin https://rhea-so:$AccessToken@github.com/rhea-so/rhea-so.github.io.git/

git add -fA
git commit --allow-empty -m "$(git log source -1 --pretty=%B)"
git push -f origin main

echo "deployed successfully"