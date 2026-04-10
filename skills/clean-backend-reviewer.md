# Skill: Clean Backend Reviewer

## Purpose
Review backend code to ensure maintainability, correctness, and adherence to clean architecture principles.

## When to use
- Code reviews
- Refactoring
- Validating new features

## Checklist

### Input Validation
- DTOs must validate input (`class-validator`, `@Valid`, etc.)
- Reject invalid data early

### Error Handling
- No empty `try-catch`
- Use centralized/global error handling
- Errors must be meaningful and consistent

### Dependency Injection
- No circular dependencies
- Prefer constructor injection
- Avoid service instantiation inside methods

### Naming
- Avoid generic names (`data`, `list`, `item`)
- Use domain-driven naming

## Output Expectations
- Identify issues clearly
- Suggest concrete improvements
- Highlight missing edge cases or tests