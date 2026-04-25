---
name: code-review
description: Perform a structured code review of the user’s changes, focusing on correctness, readability, maintainability, and risks, with concise actionable feedback.
argument-hint: "Provide the code changes or pull request you want to review"
disable-model-invocation: false
user-invocable: true
compatibility: All
license: MIT
metadata:
  - type: code-review
---

# Skill: Code Review

## Overview

This skill guides the agent to perform a structured code review.

## Instructions

- Review only the changed files.
- Focus on correctness, readability, and maintainability.
- Point out risks and potential improvements.
- Keep feedback concise and actionable.

## Expected output

- A short summary.
- A list of review comments.
