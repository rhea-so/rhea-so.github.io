git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

rm -rf vendor

git remote set-url --push origin https://rhea-so:$AccessToken@github.com/rhea-so/rhea-so.github.io.git/

git add -fA
git commit --allow-empty -m "$(git log post -1 --pretty=%B)"

git checkout main
git pull origin main
git push -f origin main

echo "deployed successfully"