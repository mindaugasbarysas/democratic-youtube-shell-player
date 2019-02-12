# Contributing

All contributions are welcome. Please follow this document to meet contribution requirements.

## How to contribute

**Submit an issue** explaining the bug or a new feature. The issue should be made of 2 parts:

1. How it works. Explain the current state of functionality. For bugs, this would be the instructions on how to reproduce the error. For new feature proposals, this would explain what the current functionality is lacking and why the proposed feature is needed.
2. How it should work. Explain the desired outcome of this bug/feature.

See [this issue](https://github.com/mindaugasbarysas/democratic-youtube-shell-player/issues/1) for example.

**Submit a pull request** fixing the bug/implementing the new feature. Each pull request must reference an issue by appending a reference link (e.g. #26) to the end of the title. Each commit must also reference an issue by appending a reference link to the end of commit message.

Each pull request fixing a bug or implementing a feature should contain some form of verification - a unit test, a different kind of test, a screenshot, etc. There should be proof, that the changes do indeed work.

All pull requests should remain focused on the issue and avoid containing unrelated changes. Commits & commit history should also make sense and follow a logical path. A bad example of this would be one commit doing changes and the next one immediately fixing those changes. Please use `git rebase -i` to clean up commit history locally before pushing to remote.
