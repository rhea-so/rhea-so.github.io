git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git remote set-url --push origin https://rhea-so:$AccessToken@github.com/rhea-so/rhea-so.github.io.git/

rm -rf vendor

git add -fA
git commit --allow-empty -m "$(git log post -1 --pretty=%B)"

git push --force origin post:master

echo "deployed successfully"