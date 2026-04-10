# Skill: Clean Backend Reviewer
---
## Checklist de Calidad
- **DTOs:** Verificá que siempre existan validaciones de entrada (`class-validator` en Nest o `@Valid` en Spring).
- **Manejo de Errores:** Asegurame de que no haya `try-catch` vacíos. Proponé siempre un Global Exception Handler.
- **Inyección de Dependencias:** Validá que no se usen dependencias circulares y que se use inyección por constructor.
- **Naming:** Si ves variables como `data`, `list` o nombres genéricos, sugerí nombres basados en el dominio del negocio.
