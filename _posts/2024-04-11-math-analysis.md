---
layout: post
title: Доп. главы по Мат. Анализу
description: Дополнительные главы поматематическому анализу
tags: Math Analysis
categories: Notebooks
date: 2024-04-11
related_posts: True
tikzjax: true
pretty_table: true
toc:
  sidebar: left
---

## Действительные числа

Опр. Непустое множество  называется множеством действительных (вещественных) чисел, а его элементы — действительными (вещественными) числами, если на определены операции сложения и умножения и отношение порядка, удовлетворяющие следующим аксиома.

1. Аксиомы сложения $$(a,b\to a+b)$$:
   1. Коммутативность: $$a+b=b+a, \forall a,b\in \mathbb{R}$$;
   2. Ассоциативность: $$a+(b+c)=(a+b)+c$$;
   3. $$\exists 0\in \mathbb{R}:a+0=a,\forall a\in \mathbb{R} $$;
   4. $$\forall a\in \mathbb{R},\exists (-a)\in \mathbb{R}:a+(-a)=0,(-a)$$ называется ***противополжным числом*** для $$a$$.

2. Аксиомы умножения $$(a,b\to ab)$$:

   1. Коммутативность: $$ab=ba, \forall a,b\in \mathbb{R}$$;
   2. Ассоциативность: $$a(bc)=(ab)c$$;
   3. $$\exists 1\in \mathbb{R}, 1\ne 0:a1=a,\forall a\in \mathbb{R}  $$;
   4. $$\forall a\in \mathbb{R},a\ne 0,\exists \frac{1}{a}\in \mathbb{R}:a\frac{1}{a}=1,\frac{1}{a} $$ называется ***обратным числом*** для $$a$$.

3. Связь сложения и умножения:

   1. $$(a+b)c=ac+bc,\forall a,b,c\in \mathbb{R}$$ - дистрибутивность умножения относительно сложения.

4. Аксиомы порядка (для любых $$a,b\in \mathbb{R}$$ установлено отношение $$a\le b$$ или $$a\ge b$$):

   1. $$a\le b,b\le a \Rightarrow a=b,\forall a,b\in \mathbb{R}$$;
   2. $$a\le b,b\le c  \Rightarrow a\le c,\forall a,b,c\in \mathbb{R}$$.

5. Связь сложения и порядка:

   1. $$a\le b\Rightarrow a+c\le b+c,\forall a,b,c\in \mathbb{R}$$.

6. Связь умножения и порядка:

   1. $$0\le a, 0\le b\Rightarrow 0\le ab,\forall a,b,c\in \mathbb{R}$$.

7. Аксиома непрерывности (вариант принципа Дедекинда):

   1. Пусть $$A,B$$ - непустые подмножества $$\mathbb{R}$$, такие, что 

      $$a\le b, \forall a\in A, \forall b\in B$$

      Тогда существует $$c\in \mathbb{R}$$:

      $$a\le c\le b, \forall a\in A, \forall b\in B$$

> 实数集合就是满足以上性质的非空集合，其中的元素叫做实数。
>
> 1. 对于加法：满足交换律，结合率，有零元和逆元，
> 2. 对于乘法：满足交换律，结合率，有单位元和逆元，
> 3. 乘法对加法满足分配率，
> 4. 顺序公理以及连续性公理。
