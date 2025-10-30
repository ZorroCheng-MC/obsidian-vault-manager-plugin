---
description: Fetch YouTube video transcript and create comprehensive material entry with thumbnail and structured content analysis
argument-hint: [youtube-url-or-video-id] (YouTube URL or video ID to process)
allowed-tools:
  - Bash(uvx:*)
  - Write(*)
  - Read(*)
  - Bash(date:*)
---

## Context

- **Today's Date:** !`date "+%Y-%m-%d"`
- **YouTube URL/ID:** `$ARGUMENTS`

## Your Task

Create a comprehensive material entry for a YouTube video by fetching its transcript and analyzing the content.

### Step 1: Extract Video ID and Fetch Transcript

1. **Extract video ID** from the provided URL or use the ID directly if already provided
   ```bash
   echo "https://www.youtube.com/watch?v=VIDEO_ID&t=21s" | grep -o 'v=[^&]*' | cut -d= -f2 
   ```

2. **Fetch the transcript (English):**
   ```bash
   uvx youtube_transcript_api VIDEO_ID
   ```

### Step 2: Create Video Entry

1. **Generate filename:** Use format `[creator-name]-[descriptive-title].md`

2. **Create structured video file:**

```yaml
---
title: "[Video Title from Content Analysis]"
tags: [video]
url: https://www.youtube.com/watch?v=[VIDEO_ID]
cover: https://i.ytimg.com/vi/[VIDEO_ID]/maxresdefault.jpg
created: !date "+%Y-%m-%d"
---

## 📖 Description
[2-3 sentence description based on transcript analysis explaining what the video covers and its value]

![Video Thumbnail]([THUMBNAIL_URL])

## 🎯 Learning Objectives
What specific skills/knowledge will you gain?

## 📋 Curriculum/Contents
- [ ] [Section 1: Based on transcript structure]
- [ ] [Section 2: Based on transcript structure]
- [ ] [Section 3: Based on transcript structure]

## 📝 Notes & Key Takeaways
(User input)

## ⭐ Rating & Review
After completion:
- **Quality (1-5):** 
- **Relevance (1-5):** 
- **Would recommend:** 
```