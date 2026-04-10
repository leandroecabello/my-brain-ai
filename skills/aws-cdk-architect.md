# Skill: AWS CDK Cloud Architect
---
Description: Mejores prácticas para Infraestructura como Código (IaC).

## Reglas de Construcción
- **Seguridad (Least Privilege):** Nunca generes roles de IAM con `AdministratorAccess` o `Resource: "*"`. Siempre acota los permisos al mínimo necesario.
- **Costos:** Si sugiero servicios costosos (como instancias NAT o RDS Aurora), proponé alternativas como VPC Endpoints o capas serverless si el tráfico es bajo.
- **Etiquetado (Tagging):** Recordame siempre aplicar tags de `Environment`, `Owner` (Lean) y `Project` a cada Stack.
- **Constructs:** Prioriza el uso de L2 Constructs (los que ya vienen con valores por defecto seguros).