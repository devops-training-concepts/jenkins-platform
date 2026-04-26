def repos = [
  [name: 'app1', url: 'https://github.com/devops-training-concepts/app1-repo.git', jf: 'ci/app1.Jenkinsfile'],
  [name: 'app2', url: 'https://github.com/devops-training-concepts/app2-repo.git', jf: 'pipeline/Jenkinsfile']
]

folder('apps')

repos.each { r ->
  multibranchPipelineJob("apps/${r.name}") {
    branchSources {
      git {
        remote(r.url)
        credentialsId('git-creds')
      }
    }
    factory {
      workflowBranchProjectFactory {
        scriptPath(r.jf)
      }
    }
  }
}