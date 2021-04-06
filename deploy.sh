git config user.name "$USER_NAME"
git config user.email "$USER_EMAIL"

rm -rf vendor

git remote set-url --push origin https://rhea-so:$AccessToken@github.com/rhea-so/rhea-so.github.io.git/

git add -fA
git commit --allow-empty -m "$(git log post -1 --pretty=%B)"
git push -f origin post

git checkout main
git pull
git merge --strategy=ours master 
git checkout master
git merge --no-ff feature

echo "deployed successfully"