# Agent System

This project defines reusable AI agents and skills.

## Structure

- agents/: contains agent roles
- skills/: contains reusable tasks

## Execution Model

When performing a task:

1. Select the appropriate agent
2. Load relevant skills
3. Execute step by step
4. Validate before applying changes

## Rules

- Always explain decisions
- Prioritize maintainability and scalability
- Avoid unnecessary complexity