# demo-api-chart

# Chart pages
pages: https://doomokun.github.io/demo-api

repo: https://github.com/doomokun/demo-api
git: git@github.com:doomokun/demo-api.git

branch: develop/docs

# Helm Commands
```
$ helm repo add demo-api-repo https://doomokun.github.io/demo-api

$ helm package .
$ helm repo index .
$ helm repo index . --url https://doomokun.github.io/demo-api

$ helm upgrade --install app-server demo-api-repo/demo-api --set appServer.image.repository=${args.image} --set appServer.image.tag=${args.tag} --namespace=3-tier-app --create-namespace

$ helm repo list
$ helm search repo
$ helm install #{chart name you like} #{helm search repo NAME}

$ helm list
$ helm delete #{NAME}
$ helm delete --purge #{NAME}
```