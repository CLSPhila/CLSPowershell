# CLS Powershell Scripts

A collection of scripts for administration of various CLS services.

## Important: Data only goes in `data/`

The output of scripts should never be added to the git repository. for this reason, the `.gitignore` file ignores any files included in the `data/` directory as well as any `.csv` files. Any scripts you write should make sure they write to `data/` (or a different directory outside this repo altogether).

**Also try to avoid putting organization- or user-specific values in scripts.** These pieces of data should be passed as parameters, not hard-coded into scripts. Certainly this won't always be avoidable, but its a nice practice.