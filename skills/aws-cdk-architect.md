# Skill: AWS CDK Architect

## Purpose
Design and review AWS infrastructure using CDK following best practices for security, cost, and scalability.

## When to use
- Designing new infrastructure
- Reviewing CDK stacks
- Optimizing AWS costs or permissions

## Rules

### Security
- Never use `AdministratorAccess`
- Avoid `Resource: "*"`
- Apply least privilege IAM policies

### Cost Optimization
- Prefer serverless (Lambda, DynamoDB) when possible
- Suggest alternatives to costly resources (e.g. NAT Gateway → VPC Endpoints)
- Evaluate trade-offs between cost and performance

### Tagging
Always include:
- `Environment`
- `Owner`
- `Project`

### CDK Best Practices
- Prefer L2 constructs over L1
- Avoid hardcoding values (use config/env)
- Ensure stacks are modular and reusable

## Output Expectations
- Explain decisions and trade-offs
- Highlight risks (security, cost, scalability)
- Suggest improvements if applicable