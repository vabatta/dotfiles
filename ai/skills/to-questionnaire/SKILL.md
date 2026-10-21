---
name: to-questionnaire
description: "Turns a decision the user cannot answer alone into a fillable questionnaire for the person who holds the knowledge. Use when the missing information lives with another human rather than in the code, history, or sources."
---

# To questionnaire

Turn something the user cannot answer alone into a questionnaire, a Markdown document handed to one person, filled async or in a meeting. The recipient holds knowledge the user lacks.

## Grill the send, not the subject

Interview the user only about the send, meaning who it goes to and what they need back. Questions target the gap between the recipient's knowledge and the user's need. For knowledge that lives in code or history instead, use **why** or **how**.

## Steps

Skip a step whose answer the request already gives. When no human can answer, record the recommended answer as an assumption in the questionnaire and continue.

1. Who is it going to, and who is it from? One exchange. Recipient role, expertise, relationship, and the sender's name. Done when you know who and what they know that the user does not.
2. What do you need back, and by when? One exchange. The decisions or facts the user cannot resolve alone, and the deadline. Done when you have a concrete list of what the user must be able to do or decide, plus a deadline or "no deadline".
3. Write the questionnaire. Draft questions at the gap, follow the structure below, write to `.agent/questionnaires/<slug>.md`, and report the path. Do not send it. The user hands it over. Done when the file exists, every step-2 item is covered, and the reply names the path.

## Document structure

Frame it as a discovery questionnaire. Put the most important questions first, since async recipients answer in one pass. Group under `##` theme headings once there is more than a handful.

- Title, then Purpose, From, To, and how the answers will be used.
- Context, one orienting paragraph.
- How to answer, covering the deadline, the effort, that partial answers and "I do not know" are useful, and how to flag uncertainty.
- Themed sections of one-idea, non-compound questions, each with an answer stub and a one-line "why this matters" only where it could be misread.
- An "Anything else?" catch-all.

For the interview that settles the subject itself, before it is written down, use **grill**.
