---
title: {{ replace .Name "-" " " | title }}
date: {{ dateFormat "2006-01-02" .Date }}
lastmod: {{ dateFormat "2006-01-02" .Date }}
draft: true
keywords: ["Threeq", "博客", "程序员", "架构师"]
categories:
 - 笔记
tags:
 - 笔记
toc: true
comment: true
description: ""

autoCollapseToc: false
postMetaInFooter: false
hiddenFromHomePage: false

contentCopyright: false
reward: false
mathjax: false
mathjaxEnableSingleDollar: false

flowchartDiagrams:
  enable: false
  options: ""

sequenceDiagrams: 
  enable: false
  options: ""
---

## {{ .Name }}
