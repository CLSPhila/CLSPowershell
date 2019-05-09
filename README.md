# CLS Powershell Scripts

A collection of scripts for administration of various CLS services.

## Important: Data only goes in `data/`

The output of scripts should never be added to the git repository. for this reason, the `.gitignore` file ignores any files included in the `data/` directory as well as any `.csv` files. Any scripts you write should make sure they write to `data/` (or a different directory outside this repo altogether).

**Also try to avoid putting organization- or user-specific values in scripts.** These pieces of data should be passed as parameters, not hard-coded into scripts. Certainly this won't always be avoidable, but its a nice practice.


## Disclaimer

These are a few scripts we've been collecting over time. They might be useful references, or perhaps the scripts themselves could be directly useable, or they might be totally broken or do unexpected damage. We don't regularly test them, or even use all of them very often, so we can't say anything about whether they work as intended or described in the documentation. **Use entirely at your own risk. Understand the code before running it.**