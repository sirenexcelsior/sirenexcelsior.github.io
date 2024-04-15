---
layout: post
title: 吉米多维奇习题集 - 不定积分
description: 
tags: Math Analysis
categories: Notebooks
date: 2024-04-11
related_posts: True
tikzjax: true
pretty_table: true
toc:
  sidebar: right
---

## 一些有用的书籍

- [Лекции по математическому анализу](https://sirenexcelsior.github.io/assets/pdf/math_analysis/Лекции_по_математическому_анализу.pdf)
- [Сборник задач и упражнений по математическому анализу](https://sirenexcelsior.github.io/assets/pdf/math_analysis/Сборник_задач_и_упражнений_по_математическому_анализу.pdf)
- [吉米多维奇数学分析习题集](https://sirenexcelsior.github.io/assets/pdf/math_analysis/俄罗斯数学教材选译_10_数学分析习题集根据2010年俄文版翻译_俄Б_П_吉米多维奇_高等教育出版社_2010.pdf)

## 不定积分的基本性质

$$d[\int f(x)dx]=f(x)dx, \int d\Phi (x)+C$$

$$\int Af(x)dx=A\int f(x)dx,A=const,A\ne 0$$

$$\int[f(x)+g(x)]dx=\int f(x)dx+\int g(x)dx$$

## 最简积分表

$$\begin{aligned}&\mathrm{I.}\int x^{n}\mathrm{d}x=\frac{x^{n+1}}{n+1}+C(n\neq-1).\quad\mathrm{I.}\int\frac{\mathrm{d}x}{x}=\ln|x|+C(x\neq0).\\&\mathrm{II.}\int\frac{\mathrm{d}x}{1+x^{2}}=\begin{cases}\arctan x+C,\\-\arctan x+C.\end{cases}\quad\mathrm{W.}\int\frac{\mathrm{d}x}{1-x^{2}}=\frac{1}{2}\ln\left|\frac{1+x}{1-x}\right|+C.\\&\mathrm{V.}\int\frac{\mathrm{d}x}{\sqrt{1-x^{2}}}=\begin{cases}\arctan x+C,\\-\arccos x+C.\end{cases}\quad\mathrm{V.}\int\frac{\mathrm{d}x}{\sqrt{x^{2}\pm1}}=\ln\left|x+\sqrt{x^{2}\pm1}\right|+C.\\&\mathrm{VI.}\int a^{x}\mathrm{d}x=\frac{a^{x}}{\ln a}+C(a>0,a\neq1);\quad\int\mathrm{e}^{x}\mathrm{d}x=\mathrm{e}^{x}+C.\\&\mathrm{VII.}\int\sin x\mathrm{d}x=-\cos x+C.\quad\mathrm{IX.}\int\cos x\mathrm{d}x=\sin x+C.\\&\mathrm{X.}\int{\frac{\mathrm{d}x}{\sin^{2}x}}=-\cot x+C.\quad\mathrm{X.}\int{\frac{\mathrm{d}x}{\cos^{2}x}}=\tan x+C.\\&\mathrm{XI.}\int\sinh x\mathrm{d}x=\cosh x+C.\quad\mathrm{XII.}\int\cosh x\mathrm{d}x=\sinh x+C.\end{aligned}$$

## 利用最简积分表求积分

### 1628

$$\int (3-x^2)^3dx$$.

$$\int (3-x^2)^3dx=\int (27-27x^2+9x^4-x^6)dx$$.
$$=27x-9x^3+\frac{9}{5}x^5-\frac{1}{7}x^7+C$$.

### 1636

$$\int (1-\frac{1}{x^2})\sqrt[]{x\sqrt[]{x} }dx $$.

$$\int (1-\frac{1}{x^2})\sqrt[]{x\sqrt[]{x} }dx =\int (x^{\frac{3}{4}}-x^{-\frac{4}{5}})dx$$.

$$=\frac{4}{7}x^{\frac{7}{4}}+4x^{-\frac{1}{4}}+C=\frac{4(x^2+7)}{7\sqrt[4]{x} }+C$$.

> 可以分解成形如$$\int x^{a_1}+\cdots+x^{a_n}dx$$的不定积分。
