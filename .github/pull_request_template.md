<!--
Not all PRs will require all tests to be carried out. Delete where appropriate.
-->

<!--
MODIFY THIS AFTER your new app repo is in https://github.com/giantswarm/github
@team-halo-engineers will be automatically requested for review once
this PR has been submitted. (But not for drafts)
-->

This PR:

- adds/changes/removes etc

### Testing

Description on how cluster-cloud-director can be tested.

- [ ] fresh install works
- [ ] upgrade from previous version works

#### Other testing

Description of features to additionally test for cluster-cloud-director installations.

- [ ] check reconciliation of existing resources after upgrading
- [ ] X still works after upgrade
- [ ] Y is installed correctly

<!--
Changelog must always be updated.
-->

### Checklist

- [ ] Update changelog in CHANGELOG.md.
- [ ] Make sure `values.yaml` and `values.schema.json` are valid.
- [ ] Update `/examples` if required.

### Trigger e2e tests

<!--
We currently have one pipeline that tests both cluster creation and cluster upgrades. You can trigger this pipeline by writing this commands in a pull request comment or description
- `/run cluster-test-suites`
If for some reason you want to skip the e2e tests, remove the following line.

Note: Tests are not automatically executed when creating a draft PR
If you do want to trigger the tests while still in draft then please add a comment with the trigger.

Full docs and all optional params can be found at: https://github.com/giantswarm/cluster-test-suites#%EF%B8%8F-running-tests-in-ci
-->

/run cluster-test-suites
