# api-demo-chart

# Chart pages
pages: https://doomokun.github.io/api-demo-chart

repo: https://github.com/doomokun/api-demo-chart
git: git@github.com:doomokun/api-demo-chart.git

branch: main

# Helm Commands
```
$ helm repo add api-demo-repo https://doomokun.github.io/api-demo-chart

$ helm package .
$ helm repo index .
$ helm repo index . --url https://doomokun.github.io/api-demo-chart

$ helm upgrade --install app-server api-demo-repo/api-demo-chart --set appServer.image.repository=${args.image} --set appServer.image.tag=${args.tag} --namespace=3-tier-app --create-namespace

$ helm repo list
$ helm search repo
$ helm install #{chart name you like} #{helm search repo NAME}

$ helm list
$ helm delete #{NAME}
$ helm delete --purge #{NAME}
```