# NSFW Publishing Workflow

This is the required flow for every new NSFW meme entry.

## Objective

Ensure every meme has:
- one source folder in NSFW-memes,
- one dedicated public page in nsfw/memes,
- one card in nsfw/index.html,
- reproducible build docs (prompt, card, metadata).

No raw-asset-only links in NSFW hub cards.

## Source of Truth

- Build assets and docs live in NSFW-memes/<slug>/
- Public presentation lives in nsfw/memes/<page-slug>.html
- NSFW hub index is nsfw/index.html

## Required Folder Contract

Per meme slug folder in NSFW-memes:
- PROMPT_CHATGPT.md
- MEME_CARD.md
- metadata.json
- assets/original.png or assets/original.jpg
- exports/

## Publish Checklist

1. Confirm meme folder contract exists and files are complete.
2. Pick primary render in assets/original.* or exports/*.
3. Create a dedicated page in nsfw/memes/<page-slug>.html.
4. Include on that page:
   - title and lead,
   - primary image and caption,
   - definition section,
   - when-to-use section,
   - build-file links (prompt, card, metadata),
   - back link to nsfw/index.html.
5. Add or update card in nsfw/index.html.
6. Card link must point to nsfw/memes/<page-slug>.html.
7. Card must include docs links to prompt and meme card.
8. Run validation:
   - all links resolve,
   - image path exists,
   - no missing files,
   - no syntax errors in changed html.

## Naming Rules

- Meme folder slug can include UUID suffix from import.
- Public page slug should be human-readable and stable.
- Keep title casing consistent with doctrine/campaign naming.

## Campaign Import Rule

When importing campaign outputs:
- keep every imported meme under NSFW-memes/poc-*/,
- pick one hero artifact per campaign for public hub card,
- still keep all variants in source folders for traceability.

## Fast Pattern To Reuse

Use an existing page as template:
- nsfw/memes/time-traveling-liver-eating-brute.html

Then replace:
- title, description, lead,
- image path and alt,
- definition text,
- docs links.

## Automation Shortcut

Use the page generator script to avoid manual copy/paste drift:

```powershell
cd B1C3-BLOG/NSFW-memes
.\_tools\new-meme-page.ps1 -Slug "<meme-folder-slug>" -PageSlug "<public-page-slug>" -Title "<Public Title>"
```

Optional fields for better first draft quality:
- `-Lead`
- `-AltText`
- `-Definition`
- `-WhenToUse`
- `-Force` to overwrite an existing page.

## Definition of Done

A meme is publish-ready only when all three are true:
- source docs complete in NSFW-memes/<slug>/,
- dedicated entry page exists in nsfw/memes/<page-slug>.html,
- NSFW hub card points to that entry page.
