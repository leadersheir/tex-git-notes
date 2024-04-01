## Tex-Git-Notes

A tool to create and manage LaTex notes with git.

### Commands

#### Create New Project
`new_proj project-name`

#### Update readme with a new session
`new_sess session-description external-resources`

### The Tex-Git-Notes Workflow
Each study material gets its own git repository. The repository contains a readme file containing information about the primary material and listing sessions of study of that material. The repository contains a _notes_ folder containing a latex document repository that contains latex notes for the material. The repository also contains external resources referred to while studying the material.

A new commit is made every session. The message is of little significance; the session name is recorded in the readme. The notes and external resources are version managed in this way should they change in the future.