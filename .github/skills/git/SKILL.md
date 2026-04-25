---
name: git
description: "Git is a distributed version control system that tracks changes in files and coordinates work among multiple developers."
argument-hint: "Provide the commit message or changes you want to commit"
disable-model-invocation: false
user-invocable: true
compatibility: All
metadata:
  - type: git
---

Goal:
Create clean commits

Steps:

1. Analyze changes
2. Detect type (feat/fix/refactor/test/docs)
3. Generate message

Format:
<type>(scope): summary
