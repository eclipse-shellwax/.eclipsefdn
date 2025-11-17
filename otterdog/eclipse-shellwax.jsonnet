local orgs = import 'vendor/otterdog-defaults/otterdog-defaults.libsonnet';

orgs.newOrg('tools.shellwax', 'eclipse-shellwax') {
  settings+: {
    web_commit_signoff_required: false,
    workflows+: {
      actions_can_approve_pull_request_reviews: false,
    },
  },
  secrets+: [
      orgs.newOrgSecret('GPG_KEY_ID') {
      value: "pass:bots/tools.shellwax/gpg/key_id",
    },
    orgs.newOrgSecret('GPG_PASSPHRASE') {
      value: "pass:bots/tools.shellwax/gpg/passphrase",
    },
    orgs.newOrgSecret('GPG_PRIVATE_KEY') {
      value: "pass:bots/tools.shellwax/gpg/secret-subkeys.asc",
    },
    orgs.newOrgSecret('SCP_KEY') {
      value: "pass:bots/tools.shellwax/projects-storage.eclipse.org/id_rsa",
    },
    orgs.newOrgSecret('SCP_PASSPHRASE') {
      value: "pass:bots/tools.shellwax/projects-storage.eclipse.org/id_rsa.passphrase",
    },
    orgs.newOrgSecret('SCP_USERNAME') {
      value: "pass:bots/tools.shellwax/projects-storage.eclipse.org/username",
    },
  ],
  webhooks+: [
    orgs.newOrgWebhook('https://ci.eclipse.org/shellwax/github-webhook/') {
      content_type: "json",
      events+: [
        "pull_request",
        "push"
      ],
    },
  ],
  _repositories+:: [
    orgs.newRepo('shellwax') {
      allow_merge_commit: true,
      allow_update_branch: false,
      default_branch: "master",
      delete_branch_on_merge: false,
      dependabot_security_updates_enabled: true,
      description: "Shell script editor plugin for Eclipse ",
      homepage: "https://marketplace.eclipse.org/content/shellwax",
      topics+: [
        "eclipse-plugin",
        "shell-script"
      ],
      web_commit_signoff_required: false,
      workflows+: {
        default_workflow_permissions: "write",
      },
    },
  ],
} + {
  # snippet added due to 'https://github.com/EclipseFdn/otterdog-configs/blob/main/blueprints/add-dot-github-repo.yml'
  _repositories+:: [
    orgs.newRepo('.github')
  ],
}