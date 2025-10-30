---
description: Generate comprehensive study guide from any text content, document, or context
argument-hint: [content-source] (file path, URL, or direct text to create study guide from)
allowed-tools:
  - Read(*)
  - Write(*)
  - Bash(curl:*)
  - Bash(date:*)
  - Bash(wc:*)
  - Bash(head:*)
  - Bash(tail:*)
---

## Context

- **Today's Date:** !`date "+%Y-%m-%d"`
- **Source Input:** `$ARGUMENTS`
- **Purpose:** Create comprehensive study guide with learning objectives, structured content, and assessment materials

## Your Task

Transform any content source into a structured, comprehensive study guide optimized for learning and retention.

### Step 1: Content Ingestion

**Determine input type and process accordingly:**

1. **If file path provided:**
   ```bash
   cat "$ARGUMENTS"
   ```

2. **If URL provided:**
   ```bash
   curl -L "$ARGUMENTS" 2>/dev/null
   ```

3. **If direct text:** Use the provided content directly

### Step 2: Content Analysis

Analyze the ingested content to identify:
- **Main topics and themes**
- **Key concepts and terminology**
- **Hierarchical structure**
- **Complexity level**
- **Subject domain**
- **Learning prerequisites**

### Step 3: Generate Study Guide

Create file: `[date]-[topic-name]-study-guide.md`

```yaml
---
title: "Study Guide: [TOPIC-NAME]"
tags: [study-guide, learning, [domain-specific-tags]]
source: [SOURCE-REFERENCE]
created: [DATE]
difficulty: [beginner|intermediate|advanced]
estimated-time: [X hours]
---

## 📖 Overview

**Subject:** [TOPIC-NAME]
**Source:** [SOURCE-REFERENCE]
**Generated:** [DATE]

### 🎯 Learning Objectives
By the end of this study session, you will be able to:
- [ ] [Specific objective 1 based on content analysis]
- [ ] [Specific objective 2 based on content analysis]
- [ ] [Specific objective 3 based on content analysis]
- [ ] [Additional objectives...]

### ⏱️ Study Plan
- **Total Estimated Time:** [X hours]
- **Difficulty Level:** [Level]
- **Prerequisites:** [Required knowledge]
- **Recommended Study Method:** [Active reading|Practice-based|Mixed approach]

## 📚 Core Content Structure

### Part 1: Fundamentals
**Time Allocation:** [X minutes]

#### Key Concepts:
- **[Concept 1]:** [Brief explanation]
- **[Concept 2]:** [Brief explanation]
- **[Concept 3]:** [Brief explanation]

#### Essential Questions:
- [ ] [Question based on fundamental concepts]
- [ ] [Question based on fundamental concepts]

### Part 2: Main Content
**Time Allocation:** [X minutes]

#### Core Topics:
1. **[Main Topic 1]**
   - Key points: [bullet points]
   - Important details: [specific information]
   - Connections: [how it relates to other topics]

2. **[Main Topic 2]**
   - Key points: [bullet points]
   - Important details: [specific information]
   - Connections: [how it relates to other topics]

[Continue for all major sections...]

### Part 3: Advanced Concepts
**Time Allocation:** [X minutes]

#### Complex Topics:
- **[Advanced Concept 1]:** [Explanation with examples]
- **[Advanced Concept 2]:** [Explanation with examples]

## 🔗 Knowledge Connections

### Prerequisites Review:
- [ ] [Concept A] - Ensure understanding before proceeding
- [ ] [Concept B] - Review if needed

### Related Topics:
- **Builds on:** [Previous knowledge areas]
- **Leads to:** [Future learning opportunities]
- **Cross-references:** [Related subjects/skills]

## 💡 Study Strategies

### Active Learning Techniques:
1. **Summarization:** Create your own summaries of each section
2. **Questioning:** Generate additional questions beyond those provided
3. **Application:** Think of real-world applications for each concept
4. **Teaching:** Explain concepts aloud or to someone else

### Memory Aids:
- **Key Terms:** [Important vocabulary with definitions]
- **Mnemonics:** [Memory devices for complex information]
- **Visual Connections:** [Suggested diagrams or mind maps]

## 📋 Study Checklist

### Before You Begin:
- [ ] Set aside uninterrupted study time
- [ ] Prepare note-taking materials
- [ ] Review prerequisites if needed
- [ ] Set specific learning goals

### During Study:
- [ ] Take active notes
- [ ] Answer embedded questions
- [ ] Create examples for abstract concepts
- [ ] Pause to summarize each section

### After Completion:
- [ ] Review learning objectives
- [ ] Complete self-assessment
- [ ] Identify areas needing review
- [ ] Plan follow-up study if needed

## 🧠 Self-Assessment

### Comprehension Check:
Rate your understanding (1-5 scale):
- [ ] Fundamental concepts: ___/5
- [ ] Main content areas: ___/5
- [ ] Advanced topics: ___/5
- [ ] Practical applications: ___/5

### Key Questions:
1. [Essential question based on content]
   - Your answer: ________________

2. [Application question]
   - Your answer: ________________

3. [Synthesis question connecting multiple concepts]
   - Your answer: ________________

### Next Steps:
- [ ] Areas requiring additional study: ________________
- [ ] Related topics to explore: ________________
- [ ] Practical applications to try: ________________

## 📚 Additional Resources

### For Deeper Learning:
- [Suggested additional readings]
- [Related online courses or tutorials]
- [Practice exercises or projects]

### Quick Reference:
- **Key Terms:** [Glossary of important terms]
- **Formulas/Rules:** [Important formulas or principles]
- **Examples:** [Practical examples for reference]

## 📝 Study Notes
[Space for personal notes, insights, and observations during study]

## ⭐ Reflection
**After completing this study guide:**
- **Most valuable insight:** ________________
- **Most challenging concept:** ________________
- **Confidence level (1-10):** ___/10
- **Would recommend to others:** Yes/No
- **Suggested improvements:** ________________
```

### Step 4: Content Optimization

1. **Adjust complexity** based on content analysis
2. **Create appropriate time estimates** based on content length and difficulty
3. **Generate relevant questions** that test understanding
4. **Suggest practical applications** where applicable
5. **Include domain-specific study strategies** based on subject matter

### Step 5: Integration Features

- **Cross-reference** with existing vault content using semantic search
- **Tag appropriately** for future discovery
- **Link to related** study guides or idea files
- **Suggest follow-up** study materials or next steps