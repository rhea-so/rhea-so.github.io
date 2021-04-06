git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

git remote set-url --push origin https://rhea-so:$AccessToken@github.com/rhea-so/rhea-so.github.io.git/

rm -rf vendor

git add -fA
git commit --allow-empty -m "$(git log post -1 --pretty=%B)"

git checkout -b build post
git checkout main
git pull
git checkout build
git merge --strategy=ours master
git checkout master
git merge --no-ff feature
git push

echo "deployed successfully"