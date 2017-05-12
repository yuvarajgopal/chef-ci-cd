
cicd-chef
=========

some scripts for chef-related bamboo pipelines


usage
-----

1. Make sure the chef-repo or cookbook is the **FIRST** repo checked out by the bamboo pipeline

2. Check this repository out as the last, typically, repo in the pipeline, and, typically, in the `cicd/` directory.

3. Call the appropriate script in the pipeline instead of the old
literal script.  For example, the chef-repo script (under Plan Configuration> Stages > Default Job) would likely be the following.

```bash
cicd/bin/release-chef-repo
```

chef-repo tools
---------------

### `bin/release-chef-repo`

This script will process the chef-repo in three phases.

1. Build
2. Check
3. Publish


1. **Build Phase**

    * The .chef artifacts will be copied into the `.chef/`
    * If any overlays are present, they will be applied.  The only currently defined overlay directory is `chef-repo-prod/`.

2.  **Check Phase**

    * Validate *every* JSON file.
	    * runs jq to validate JSON syntax
		* checks name: property on roles and environments
    * Use `berks install` or `berks update` to resolve the cookbook dependencies

3. **Publish Phase**

    * The environments, roles, and data_bags will each be sent via `knife upload` commands.
    * The cookbooks will be sent via the `berks upload` command.

NOTE: The **publish** phase will only be executed for the **master** branch of the **first** Bamboo plan repository, which needs to be the chef-repo itself.

cookbook tools
--------------

### `bin/test-chef-cookbook`

* Currently, this just calls `rake bamboo`.

### bin/kitchen-clean.sh

Do a `kitchen destroy` AND forced `vagrant destroy` commands to make sure there are no orphaned VMs attached to the current directory.

This can be called before any `kitchen` testing

Notes

1. The current version of vagrant on the bamboo agents DOES NOT
support the `vagrant global-status` command, so that section is commented out for now.
    * The current script will look for any virtualbox instances that skave kitchen in their name.  It will kill a virtualbox process for that vm, if it exists, and then it will unregister/delete the vm.
