# aido 🧠

**"ai đó" = who’s there?"** (Vietnamese)  
**"AI-Do" = AI does it.**

_Aido_ is a shell-based assistant that helps you generate and understand problems from **Theory of Computation** — from DFAs to CFGs to PDAs and beyond.

Built by **Michael Nguyen** with the help of **GPT**, `aido` is your personalized ToC tutor in the terminal.

---

## 🚀 What It Does

- ✅ DFA transition tables + diagrams  
- ✅ CFGs and CNF conversions  
- ✅ PDA construction + stack behavior  
- ✅ Parse trees (ASCII + LaTeX/TikZ)  
- ✅ Step-by-step derivations  
- ✅ Quiz and explanation generation

---

## 🛠 How To Use

From Terminal:

```bash
chmod +x aido.sh
./aido.sh "Design a DFA that accepts strings ending in 'ab'"

./aido-out/theory-YYYY-MM-DD_HH-MM-SS.md

---

### 🔹 Part 3 (Sample Prompts + Project Info)

```markdown
---

## 🧠 Sample Prompts

```bash
./aido.sh "Design a DFA for strings ending in ab"
./aido.sh "Give a CFG for the language { aⁿbⁿ | n ≥ 0 }"
./aido.sh "Convert the CFG S → ASA | aB to CNF"
./aido.sh "Draw a parse tree for ababcc"
./aido.sh "Design a PDA for palindromes over {a,b}"

---

Paste all 3 chunks into `README.md`, save it, then run:

```bash
git add README.md
git commit -m "Add complete README 💾"
git push
