# Git Commands and Best Practices

This document provides an overview of commonly used Git commands and best practices for effective version control.

---

## Common Git Commands

### 1. **Initialization**

- `git init`: Initialize a new Git repository in the current directory.

### 2. **Cloning**

- `git clone <repository-url>`: Clone an existing repository to your local machine.

### 3. **Staging and Committing**

- `git add <file>`: Stage a specific file for commit.
- `git add .`: Stage all changes in the current directory.
- `git commit -m "Commit message"`: Commit staged changes with a descriptive message.

### 4. **Branching**

- `git branch`: List all branches.
- `git branch <branch-name>`: Create a new branch.
- `git checkout <branch-name>`: Switch to a specific branch.
- `git checkout -b <branch-name>`: Create and switch to a new branch.

### 5. **Merging**

- `git merge <branch-name>`: Merge a branch into the current branch.

### 6. **Pulling and Pushing**

- `git pull`: Fetch and merge changes from the remote repository.
- `git push`: Push local commits to the remote repository.

### 7. **Viewing History**

- `git log`: View commit history.
- `git log --oneline`: View a simplified commit history.

### 8. **Undoing Changes**

- `git reset <file>`: Unstage a file.
- `git reset --hard`: Reset the working directory and staging area to the last commit.
- `git revert <commit-hash>`: Create a new commit that undoes a specific commit.

### 9. **Tagging**

- `git tag <tag-name>`: Create a new tag.
- `git push origin <tag-name>`: Push a tag to the remote repository.

### 10. **Cherry-Picking**

- `git cherry-pick <commit-hash>`: Apply the changes from a specific commit to the current branch.
- `git cherry-pick -n <commit-hash>`: Apply the changes from a specific commit without committing them.

### 11. **Undoing a Commit**

- `git revert <commit-hash>`: Create a new commit that undoes the changes of a specific commit.
- `git reset --soft <commit-hash>`: Undo commits while keeping changes staged.
- `git reset --mixed <commit-hash>`: Undo commits and unstage changes, but keep them in the working directory.
- `git reset --hard <commit-hash>`: Undo commits and discard all changes in the working directory.

---

## Best Practices

1. **Write Clear Commit Messages**
   - Use concise and descriptive commit messages.
   - Follow the format: `<type>: <subject>` (e.g., `fix: resolve login bug`).

2. **Use Branches**
   - Create separate branches for features, bug fixes, and experiments.
   - Merge branches only after thorough testing.

3. **Pull Before Push**
   - Always pull the latest changes from the remote repository before pushing your changes.

4. **Avoid Committing Sensitive Data**
   - Use `.gitignore` to exclude sensitive files (e.g., API keys, passwords).

5. **Review Changes Before Committing**
   - Use `git diff` to review changes before staging or committing.

6. **Rebase with Caution**
   - Use `git rebase` for a cleaner commit history, but avoid rebasing shared branches.

7. **Tag Important Releases**
   - Use tags to mark significant releases or milestones.

8. **Backup Regularly**
   - Push changes to the remote repository frequently to avoid data loss.

9. **Use Cherry-Picking Sparingly**
   - Cherry-pick commits only when necessary, such as for hotfixes or isolated changes.
   - Avoid cherry-picking large or complex commits to prevent conflicts.

10. **Undo Commits Carefully**

- Use `git revert` for public branches to maintain a clear history.
- Use `git reset` for local branches when you need to rewrite history.
- Always double-check the commit hash before running reset or revert commands.

---

By following these commands and best practices, you can maintain a clean and efficient Git workflow.
