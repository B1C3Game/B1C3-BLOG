# ChatGPT Prompt - Meme Is Relation, Not Image (POC-07)

## Intent

Show that the meme is cultural transmission between people, not a static screen artifact, and preserve the iteration trail including errors and fixes.

## Winning Prompt Snapshot

Use this in ChatGPT image generation:

```
High-resolution vertical systems poster.
Headline: SAME FILE, DIFFERENT FRAME, DIFFERENT OUTCOME.
Two lanes with groups on both sides.
Composition budget: 80-90% people/cultural interaction, 10-20% other. 0% screens and modern tech.
Lane A: aligned frame, visible remix and quote loops.
Lane B: frame mismatch, local discussion but no replication chain.
No lonely figure, no mockery, no smart-vs-dumb coding.
Show human cultural carriers in both lanes (spoken phrases, gesture mimicry, rhythm cues), not only screens.
Do not place phones. No devices.
Keep tone serious, empirical, dignified.
Use fictional, non-identifiable people only. No real people, no logos, no copyrighted characters, no government insignia, no gore.
```

## Accepted Outputs

- cdde1152-6d55-45fc-8d9e-c750476c24ad.png (current winner)
- 165a1cd9-4d04-4be7-b743-8e8d1abf79d8.png (strong culture-first)
- 47e236c3-0621-43d8-a7f5-3cce5489c29c.png (good intermediate)

## Problem Log (Full Iteration)

1. Timeout / long render stalls
- Symptom: prompt runs for several minutes then fails.
- Cause pattern: over-constrained long prompt with conflicting composition instructions.
- Fix: compact fallback prompts and clearer priority constraints.

2. Gatekeeping vibe
- Symptom: output implied "people who get memes" versus "people who do not".
- Cause pattern: lane language encoded status hierarchy.
- Fix: equal-dignity framing, context mismatch only, no smart-vs-dumb coding.

3. Lonely-outcast trope
- Symptom: one side depicted isolated, mocked individual as failure symbol.
- Cause pattern: model defaulted to simple visual metaphor.
- Fix: explicit ban on lonely-outcast composition, groups on both sides.

4. Screen dominance drift
- Symptom: 70-90% of image focused on phones/screens despite culture-first goal.
- Cause pattern: meme keyword pulled model toward image-macro defaults.
- Fix: hard composition budget and explicit no-device/no-phone constraints.

5. Doctrinal mismatch in minimal thesis
- Symptom: "file is necessary" framing contradicted campaign thesis.
- Cause pattern: residual file-first logic from earlier drafts.
- Fix: switched to "It was culture all along" and optional-carrier branch model.

## Exports Trail

All generated variants are intentionally preserved in `exports/` as evidence of prompt evolution and doctrinal correction.
