# Git Submodule

Git submodules are a way to keep a Git repository as a subdirectory of another Git repository. This can be useful for including libraries or other dependencies in your project.

## Adding a Submodule

To add a submodule, use the following command:

```sh
git submodule add <repository_url> <path>
```

For example, to add a submodule located at `https://github.com/example/repo.git` to the `libs/repo` directory, you would run:

```sh
git submodule add https://github.com/example/repo.git libs/repo
```

## Cloning a Repository with Submodules

When you clone a repository that contains submodules, you need to initialize and update the submodules:

```sh
git clone <repository_url>
cd <repository_directory>
git submodule update --init --recursive
```

## Updating Submodules

To update the submodules to the latest commit on their respective branches, use:

```sh
git submodule update --remote --merge
```

## Removing a Submodule

To remove a submodule, follow these steps:

1. Remove the submodule entry from the `.gitmodules` file.
2. Remove the submodule directory from the repository.
3. Remove the submodule configuration from the `.git/config` file.
4. Run the following command to remove the submodule from the Git index:

```sh
git rm --cached <path_to_submodule>
```

For example, to remove the `libs/repo` submodule:

```sh
git rm --cached libs/repo
rm -rf libs/repo
```

## Summary

Git submodules are a powerful feature for managing dependencies in your projects. By following the steps above, you can add, update, and remove submodules as needed.
