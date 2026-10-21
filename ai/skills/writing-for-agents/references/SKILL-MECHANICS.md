# Skill mechanics

The skill-specific branch of writing for agents.

## Model-invoked versus user-invoked

A model-invoked skill pays context load, since its description is always loaded and triggers it. A user-invoked skill costs cognitive load instead, since the human must remember to call it. Choose by which load you can afford. A high-frequency, must-fire trigger belongs on the model side.

## Splitting by invocation

Split a skill when one branch is user-invoked and another is model-invoked, since the two pay different loads and want different descriptions.

## Router skills

A router is one user-invoked skill that names the others and routes to the right one for the kind of work in front of you. It can hint at a skill but cannot fire it, so each target still needs its own trigger.

## Checking a skill

The description is the pointer, so test that it triggers on the branches it names and on nothing else. A branch that never fires, or fires on the wrong work, is a wording bug in the description before it is a body bug.
