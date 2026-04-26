folder('apps')

['app1-repo','app2-repo'].each { repo ->
  pipelineJob("apps/${repo}") {
    definition {
      cpsScm {
        scm {
          git {
            remote {
              url("https://github.com/devops-training-concepts/${repo}.git")
            }
            branch('main')
          }
        }
        scriptPath('Jenkinsfile')
      }
    }
  }
}