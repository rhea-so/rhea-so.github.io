git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git checkout main
git pull origin main

git add .
git commit -m "circle ci"
git push -f origin main
git remove -v

echo "deployed successfully"