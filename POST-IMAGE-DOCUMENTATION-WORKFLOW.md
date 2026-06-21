# Post Image Documentation Workflow

This workflow applies NSFW-level traceability to regular blog post image sets.

## Goal

For image-heavy posts, every published image should have:
- source prompt trace,
- interpretation card,
- machine-readable metadata,
- index mapping to arc position and post usage.

## Scope

Use this for image sets that carry doctrine meaning or interpretation burden.

Examples:
- RF-warning arc images
- campaign-style public advisory visuals

## Folder Contract

For each post package folder, create:

- image-docs/INDEX.md
- image-docs/_template/PROMPT_SOURCE.md
- image-docs/_template/IMAGE_CARD.md
- image-docs/_template/metadata.json
- image-docs/<image-slug>/PROMPT_SOURCE.md
- image-docs/<image-slug>/IMAGE_CARD.md
- image-docs/<image-slug>/metadata.json

## Required Fields Per Image

1. Prompt Source
- generation intent
- key constraints
- variant notes
- source link (or TBA if not available yet)

2. Image Card
- one-line definition
- interpretation
- when to use
- failure/misread risk

3. Metadata JSON
- slug
- title
- status (draft/reviewed/published)
- post_path
- static_image_path
- arc_step
- prompt_source_link
- notes

## Publish Qualification

An image is documentation-complete when:
- listed in image-docs/INDEX.md,
- has all 3 per-image files,
- static path matches an actual published file,
- status is reviewed or published.

## Minimum Review Pass

Before final publish:
- verify alt text in post HTML,
- verify arc order in post body,
- verify interpretation card is not contradictory,
- verify prompt source has enough detail for regeneration.
