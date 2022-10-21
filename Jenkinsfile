def label = "slave-${UUID.randomUUID().toString()}"

def helmInit() {
  	println "初始化 helm client"
  	// sh "helm init --client-only --stable-repo-url https://mirror.azure.cn/kubernetes/charts/"
}

def helmRepo(Map args) {
	println "添加 course repo"
	sh "helm repo add 3-tier-app-repo https://doomokun.github.io/3-tier-app-chart"

	println "更新 repo"
	sh "helm repo update"
}

def helmDeploy(Map args) {
	helmInit()
	helmRepo(args)

	if (args.dry_run) {
		println "Debug 应用"
		sh "helm upgrade --dry-run --debug --install ${args.name} ${args.chartDir} --set appServer.image.repository=${args.image} --set appServer.image.tag=${args.tag} --set appWeb.service.type=NodePort --set appServer.service.type=NodePort --namespace=${args.namespace} --create-namespace"
	} else {
		println "部署应用"
		sh "helm upgrade --install ${args.name} ${args.chartDir} --set appServer.image.repository=${args.image} --set appServer.image.tag=${args.tag} --set appWeb.service.type=NodePort --set appServer.service.type=NodePort --namespace=${args.namespace} --create-namespace"
		echo "应用 ${args.name} 部署成功. 可以使用 helm status ${args.name} 查看应用状态"
	}
}

podTemplate(label: label, containers: [
	containerTemplate(name: 'maven', image: 'maven:3.8.5-openjdk-17', command: 'cat', ttyEnabled: true),
	containerTemplate(name: 'kubectl', image: 'cnych/kubectl', command: 'cat', ttyEnabled: true),
	containerTemplate(name: 'helm', image: 'cnych/helm', command: 'cat', ttyEnabled: true),
	containerTemplate(name: 'kaniko', image: 'gcr.io/kaniko-project/executor:debug', command: 'cat', ttyEnabled: true)
], volumes: [
  	secretVolume(mountPath: '/kaniko/.docker', secretName: 'dockercred')
]) {
	node(label) {
		def imageEndpoint = "tommydevv1/demo-api"

		stage('Fetch code') {
			git branch: 'develop', credentialsId: 'jenkins-key', url: 'https://github.com/doomokun/demo-api.git'
			script {
			    imageTag = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
			}
		}
		stage('代码编译打包') {
			try {
				container('maven') {
				    sh "mvn -f pom.xml clean -DskipTests package"
				}
			} catch (exc) {
				println "Build Fail - ${currentBuild.fullDisplayName}"
				throw(exc)
			}
		}
		stage('kaniko 构建 Docker 镜像') {
			container('kaniko') {
				sh "/kaniko/executor --context `pwd` --destination ${imageEndpoint}:${imageTag}"
			}
		}
		stage('运行 Helm') {
			container('helm') {
				echo "4. [INFO] 开始 Helm 部署"
				helmDeploy(
					dry_run     : false,
					name        : "3-tier-app",
					chartDir    : "3-tier-app-repo/3-tier-app-chart",
					namespace   : "3-tier-app",
					tag         : "${imageTag}",
					image       : "${imageEndpoint}"
				)
				echo "[INFO] Helm 部署应用成功..."
			}
		}
	}
}
