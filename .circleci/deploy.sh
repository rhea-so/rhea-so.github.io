git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git checkout main
git pull origin main

find . -maxdepth 1 ! -name '_site' ! -name '.gitignore' ! -name '.circleci' -exec rm -rf {} \;
mv _site/* .
rm -R _site/

git add -fA
git commit -m "circle ci"
git push -f origin main

echo "deployed successfully"