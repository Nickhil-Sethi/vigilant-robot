# vigilant-robot
Experiments with Infrastructure as Code

## cloudformation
### Common Gotchas

- Structure on `config`, must have `packages` child object
- DO NOT use vscode; use a barebones editor like emacs, vscode can change the encoding of command line args

### Emergency Scenarios

#### Handling Configuration Drift

- EC2Instance Deleted
- Load Balancer Deleted
- Database Deleted
- DNS Record deleted?

### Backing Up Databases

- Rollback On Delete
- Does this work even if someone deletes it manually?

### Security

- IAM permissions
- Network ACL
- Security Groups
- NoEcho on passwords; should we make them outputs?

## Thoughts on cloudformation vs terraform

### Transparency
Being able to get under the hood of the IaC tool you are using (or any tool for that manner), i.e. go deeper than the documentation, is critical for effective usage.

Brief anecdote -- when experimenting with cloudformation, I found that my `cfn-init` script was not executing, inexplicably, as the syntax was apparently correct. Thankfully, the `/opt/aws/bin/cfn-init` script is a python CLT whose source code I found on the box after a little digging. Altering the code, I found that the command line arguments' encoding was being altered by `vscode` and switching to a more barebones text editor (in fact emacs) solved the problem. 

Here Terraform wins. It's an open source product; and though digging through the source code of your tool is difficult, the ability to do so is often a make-or-break for the product. Plus, it doesn't have to be you that reads the source -- you can be reading a blog post that someone else who read the source code put together. Cloudformation does have open source static analyzers maintained by AWS such as `cfn-lint` but these are ultimately an indirect window into what's going on with your tool.

Beyond that, Terraform has a very useful feature called `plan`, which in a manner analgous to `postgres` `EXPLAIN` command, shows the intended plan for deployment of a terraform stack.

### Ease of Use
Cloudformation is a managed service

- cloudformation is managed; i.e. with terraform you have to manage a state file and locking, as well as the terraform process. what happens if the process crashes?

Handling configuration drift

Terraform has a slightly larger feature set; e.g. iterators, but I can very much see iterators being an easy way to shoot yourself in the foot. 

### Support

Terraform is more widely supported

### Conclusion

It seems terraform edges out cloudformation on most categories, but 
