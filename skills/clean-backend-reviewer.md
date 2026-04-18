# Skill: revisor de backend limpio

## Propósito

Revisar código backend para asegurar mantenibilidad, corrección y alineación con arquitectura limpia.

## Cuándo usarla

- Revisiones de código
- Refactorizaciones
- Validación de funcionalidades nuevas

## Lista de comprobación

### Validación de entrada

- Los DTOs deben validar la entrada (`class-validator`, `@Valid`, etc.)
- Rechaza datos inválidos lo antes posible

### Manejo de errores

- No uses `try-catch` vacíos
- Usa manejo de errores centralizado o global
- Los errores deben ser claros y coherentes

### Inyección de dependencias

- Sin dependencias circulares
- Prefiere inyección por constructor
- Evita instanciar servicios dentro de métodos

### Nomenclatura

- Evita nombres genéricos (`data`, `list`, `item`)
- Usa nombres orientados al dominio

## Resultado esperado

- Identifica problemas con claridad
- Propone mejoras concretas
- Destaca casos límite o pruebas faltantes
