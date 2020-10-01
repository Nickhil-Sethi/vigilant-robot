# vigilant-robot
Experiments with Infrastructure as Code

## Common Gotchas

- Structure on `config`, must have `packages` child object
- DO NOT use vscode; use a barebones editor like emacs, vscode can change the encoding of command line args

## Handling Configuration Drift

- EC2Instance Deleted
- Load Balancer Deleted

## Backing Up Databases

- Rollback On Delete
- Does this work even if someone deletes it manually?
