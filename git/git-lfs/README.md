# Git Large File Storage (LFS) Guide

Git LFS is an extension for Git that helps manage large files effectively by storing them on a remote server while keeping lightweight references in your repository.

## Installation

```bash
# Install Git LFS
git lfs install
```

## Basic Usage

1. Track large files:

```bash
git lfs track "*.psd"
git lfs track "*.zip"
```

2. Add .gitattributes:

```bash
git add .gitattributes
```

3. Use Git normally:

```bash
git add file.psd
git commit -m "Add large file"
git push origin main
```

## Common Commands

- List tracked patterns:

```bash
git lfs track
```

- Show tracked files:

```bash
git lfs ls-files
```

- Pull LFS files:

```bash
git lfs pull
```

## Tips

- Initialize Git LFS for each repository
- Track file patterns before adding files
- Commit .gitattributes file

For more information, visit [Git LFS website](https://git-lfs.com)
