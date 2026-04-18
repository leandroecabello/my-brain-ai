# Skill: arquitecto AWS CDK

## Propósito

Diseñar y revisar infraestructura en AWS con CDK siguiendo buenas prácticas de seguridad, coste y escalabilidad.

## Cuándo usarla

- Al diseñar infraestructura nueva
- Al revisar stacks de CDK
- Al optimizar costes o permisos en AWS

## Reglas

### Seguridad

- No uses `AdministratorAccess`
- Evita `Resource: "*"`
- Aplica políticas IAM con mínimo privilegio

### Optimización de costes

- Prefiere serverless (Lambda, DynamoDB) cuando encaje
- Propón alternativas a recursos costosos (p. ej. NAT Gateway → VPC Endpoints)
- Evalúa el equilibrio entre coste y rendimiento

### Etiquetado

Incluye siempre:

- `Environment`
- `Owner`
- `Project`

### Buenas prácticas de CDK

- Prefiere constructos L2 frente a L1
- Evita valores fijos en código (usa configuración o variables de entorno)
- Mantén stacks modulares y reutilizables

## Resultado esperado

- Explica decisiones y compensaciones
- Señala riesgos (seguridad, coste, escalabilidad)
- Sugiere mejoras cuando aplique
