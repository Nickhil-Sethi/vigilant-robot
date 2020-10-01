# vigilant-robot
Experiments with Infrastructure as Code

## Common Gotchas

- Structure on `config`, must have `packages` child object
- DO NOT use vscode; use a barebones editor like emacs, vscode can change the encoding of command line args

## Emergency Scenarios

### Handling Configuration Drift

- EC2Instance Deleted
- Load Balancer Deleted
- Database Deleted
- DNS Record deleted?

## Backing Up Databases

- Rollback On Delete
- Does this work even if someone deletes it manually?

## Security

- IAM permissions
- Network ACL
- Security Groups
- NoEcho on passwords; should we make them outputs?
