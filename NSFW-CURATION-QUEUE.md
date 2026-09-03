# NSFW Public Curation Queue

Status: review before next public edit

Date: 2026-09-03

## Current Finding

The public NSFW index presents approximately 46 cards as one collection, although the cards have materially different states:

- Finished campaign publishes.
- Candidates.
- Campaign picks.
- Campaign imports.
- Review-required material.
- Infrastructure/index pages.

This makes the public surface look like an unfiltered work dump.

## Proposed First Cut

Remove the following from the public NSFW index, while keeping their folders and source documentation in the repository:

### Remove From Public Index Immediately

- All cards labelled `Candidate`.
- All cards labelled `Review required`.
- All cards labelled `Campaign Import` unless explicitly reviewed and promoted.
- Infrastructure/index cards that do not represent a finished work.

This is a navigation/publication change, not an archive deletion.

## Keep Public For Now

Keep only a deliberately small selected set while the cleanup is underway:

- Newtons Ansvar.
- Aliens Exist First Contact.
- Doctrinephobia Framework.
- Transformer Emergence.
- One selected work from the POC-03/04/05/06/08 campaign picks, after checking each page.

The exact final selected set is still a judgment call. The public goal should be roughly 5-10 works, not 46.

## Keep In Repository But Do Not Promote

The following may remain available for provenance, but should not be presented as current public work:

- `Candidate 01-05`.
- `Review required` imports.
- Alternate renders of the same concept.
- Prompt/source/metadata folders.
- Historical production infrastructure.

## Review Criteria Before Promotion

- Complete dedicated page exists.
- Image and metadata links work.
- The work has a bounded point rather than only atmosphere.
- No unnecessary personal or sensitive material.
- Satire is legible without private conversation context.
- The item earns public visibility today.

## Next Action

- [x] Remove T3 Capability-First Navigation and Genius As Process, Not Identity from the public index and dedicated public pages.
- [ ] Confirm whether the broader first cut should hide only `Candidate` and `Review required`, or all remaining `Campaign Import` items too.
- [ ] Rewrite `nsfw/index.html` to show only the selected set plus an archive link.
- [ ] Rebuild or trim NSFW sitemap entries to match the selected public set.
- [ ] Check remaining selected pages and images.

## Important Boundary

Do not delete source folders as part of this curation pass. The source material may be useful for later comparison, documentation, or private research even when it no longer belongs on the public front door.
