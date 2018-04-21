---
title: 小白学 SQL 第三天：单表数据查询
date: 2018-04-21
lastmod: 2018-04-21
draft: false
keywords: ["Threeq", "博客", "程序员", "架构师", "Mysql","SQL","SQL学习","数据库","ER图"]
categories:
 - 数据库
tags:
 - 数据库
 - SQL
toc: true
comment: true
description: "数据库管理系统（DBMS）是 IT 从业者必备工具之一，你能在市面上看到的任何一个软件系统，在后面支持的一定有它的身影。 而这里面关系型数据库管理系统（RDBMS） 目前暂居了绝大部分，操作 RDBMS 的基础就是今天我们要开始学习的 SQL（结构化查询语言），所以我们有必要针对 SQL 进行系统全面的学习。同时会对数据库中的一些基础原理和设计工具进行介绍：ER 图、数据类型、范式等。适合小白用户（初学者和刚入门）。"
---

《小白学 SQL》第三天

数据查询应该是我们平时用得最多的数据库操作，所以我们优先学习数据查询，今天我们就来看看基础的数据查询操作：单表数据查询，涉及到的知识点有：

* 检索单个列
* 检索多个列
* 数据去重
* 返回定量数据集
* 排序检索数据

<!--more-->

先启动联系环境，具体启动方式和步骤请参看[《小白学 SQL 第二天：数据表创建》](https://blog.threeq.me/post/articles/noob-learn-sql/2-create-table/)。

# SELECT 语句结构

 查询数据使用的到时 SELECT 语句，首先一起看一下今天用到 SELECT 语句结构：（这里不能理解没有关系，有个印象就行，稍后我们通过后面的例子理解）

```sql
select [distinct] 列1，列2，... from table_name
[order by 列1 desc[, 列2 asc]]
[limit offset, size];
```

> **列1、列2** 列。在实际使用的时候，就是表示我们需要得到的信息，就是 E-R 图里面 `椭圆` 的部分
>
> **table_name** 表名。在实际使用的时候，就是表示我们需要到哪里获得数据，就是 E-R 图里面 `矩形` 的部分
>
> distinct 去重标识。如果多条数据完全相同的时候，只保留一条数据结果
>
> **order by** 排序语句。指定查询结果集按照特定列排序，可以同时多个列排序用`,`分割。排序可以正序(`asc`)或倒序(`desc`)
>
> **limit offset, size** 数据限定。在实际使用的时候，就是表示我们需要获得`多少数据`，就是常说的分页查询。当没有 `limit` 限定时，表示取到所有数据

要学习详细完整的  SELECT 语句结构请查看 [MySQL 官方文档](https://dev.mysql.com/doc/refman/5.7/en/select.html)。

# 查询实例

我们的学习主要是以实际使用为主，所以所有的 SQL 语句之前都会给出命题和分析。

还记得我们之前建立的数据表结构吧，这里我们会用到班级表，建议大家回顾一个班级的 E-R 图和创建表 SQL。

## 查询所有班级的所有信息

> 分析：**查询** *所有* **班级** 的 **所有信息**
>
> 1. 查询：select
> 2. 到哪里取数据：**班级**
> 3. 得到哪些信息(列)：**所有信息** （所有的*椭圆*）
> 4. 取多少数据：**所有班级** （没有`limit`）
>
> 我们将这些信息套入到 SELECT 语句结构会得到如下：
>
> > **select 班级所有信息 from 班级;**
>
> 由于 *班级所有信息* 的所有椭圆是：`标识 id、名称、班主任、开班时间、结束时间、状态、创建时间`，这样我们可以得到下面的分析结果：
>
> > **select `标识 id,名称,班主任,开班时间,结束时间,状态,创建时间`  from 班级;**

通过上面的分析我们得到了和 E-R 图对应的类 SQL 语句，现在需要把这个 sql 翻译成数据库可以执行的正式 SQL。在从 E-R 图到数据表的过程中我们在名字上有这样的对应的关系：

| E-R 图中的名称 | 数据库中的对应名称 |
| -------------- | ------------------ |
| 班级           | class              |
| 表示 id        | c_id               |
| 名称           | c_name             |
| 班主任         | c_head_teacher     |
| 开班时间       | c_start_time       |
| 结束时间       | c_end_time         |
| 状态           | c_status           |
| 创建时间       | c_created          |

按照这个对应表我们替换上面的类 SQL，得到下面的真实可执行 SQL：

```sql
select c_id,c_name,c_head_teacher,c_start_time,c_end_time,c_status,c_created from class;
```

copy 到 Navicat 的 SQL 执行其中会得到如下结果：

![](/images/articles/noob-learn-sql/03-all-01.jpeg)

执行下面这个 SQL 应该会得到和上面一样的结果

```
select * from calss;
```

这里的`*` 表示返回所有列信息，在实际使用中查询所有列或所有信息时，我们常常是用`*`代替。

## 查询所有班级的名称

> 分析：**查询** *所有* **班级** 的 **名称**
>
> 1. 查询：select
> 2. 到哪里取数据：**班级**
> 3. 得到哪些信息(列)：名称 
> 4. 取多少数据：**所有班级** （没有`limit`）
>
> 我们将这些信息套入到 SELECT 语句结构会得到如下：
>
> > **select 名称  from 班级;**
>
> 这里`名称`已经是一个存在的特定列（属性）了，所以不再替换分析了。

对照上面的映射表，我们很容易得到真实可执行 SQL：

```
select c_name from class;
```

执行 SQL 语句会得到如下结果

![](/images/articles/noob-learn-sql/03-column-01.jpeg)

试试

- [ ] 查询所有班级的名称和班主任信息

## 查询前5个班级的标识 id和名称

> 分析：**查询** *前5个* **班级** 的 *标识 id和名称*
>
> 1. 查询：select
> 2. 到哪里取数据：**班级**
> 3. 得到哪些信息(列)：标识 id 、名称 
> 4. 取多少数据：**5** (前5个)
> 5. 从哪里开始取：**0**（前5个）
>
> 我们将这些信息套入到 SELECT 语句结构会得到如下：
>
> > **select 标识 id, 名称  from 班级 limit 0,5;**
>
> **`limit 0,5`** 说明:
>
> : 我们可以建档的理解成：数据库在执行的时候，先执行没有 `limit` 限定的 SQL，得到所有的结果；然后在根据 `limit` 限定条件对数据进行 *裁剪* 返回。必须这里的`limit 0,5`: 从第 0 个(不包含 0)开始的 5 条数据（就是前 5 条数据）。大家可以想象 `limit 3,4` 的含义，并执行看看会有什么结果。

对照上面的映射表，转换得到真实可执行 SQL：

```
select c_id,c_name from class limit 0,5;
```

执行 SQL 语句会得到如下结果

![](/images/articles/noob-learn-sql/03-limit-01.jpeg)

`limit` 在实际使用的时候往往是用在分页数据查询，比如大家逛淘宝、京东都会不断翻页的查找数据。这个时候我们常常使用的表达是：按照**每页4条数据大小** **分页查询** **第3页** 班级数据的标识 id 和名称。我们来简单分析一下这个 SQL

> 分析：按照**每页4条数据大小** **分页查询** **第3页** 班级数据的标识 id 和名称
>
> 1. 查询：select
> 2. 到哪里取数据：**班级**
> 3. 得到哪些信息(列)：标识 id 、名称
> 4. 取多少数据：**4** (按照**每页4条数据大小** )
> 5. 从哪里开始取：**4 x (3-1) =  `8`**（第3页，跳过前面2页数据，从第 2 页最后一条数据开始(不包含)往后取）
>
> 我们将这些信息套入到 SELECT 语句结构会得到如下：
>
> > **select 标识 id, 名称  from 班级 limit 8,4;**
>
> 所以得到 SQL
>
> > **select c_id, c_name from class limit 8,4;**
>
> 大家执行上面的 SQL 看看结果。



试试

- [ ] 按照每页3条数据大小分页查询第4页班级数据的标识 id 、名称和班主任

# 数据去重

请执这条 SQL

```
select c_name from class;
```

大家可以看到里面有2条 `会计考试班 2` 数据，在实际使用的时候我们常常会遇到去掉重复数据需求，这是往往大家描述的时候会出现 **去掉重复**、**去重** 等修饰词。这个时候我们需要使用 SQL 的 `distinct` 关键字，请大家只想下面的 SQL

```
select distinct c_name from class;
```

> 注意: `distinct` 去重试会比较所有 `返回数据列` 。请大家执行下面两个 SQL，然后看结果和之前的 2 个 SQL 进行对比，就比较好理解了
>
> >select c_id, c_name from class;
> >
> >select distinct c_id, c_name from class;

# 排序检索

排序我们通过 2 个实例讲解，分别讲解单列排序和多列排序

## 查询所有班级信息，标识 id 大的在前面

> 分析：**查询** **所有** **班级信息**，标识 id 大的在前面
>
> 1. 查询：select
> 2. 到哪里取数据：**班级**
> 3. 得到哪些信息(列)：全部 
> 4. 排序字段：标识 id -> 倒序（大的在前面）
> 5. 取多少数据：不做限制
>
> 我们将这些信息套入到 SELECT 语句结构会得到如下：
>
> > **select *  from 班级**
> >
> > **order by 标识 id desc**;
>
> 还记得吗！如果返回所有的列，我们可以使用 `*` 标识

现在结合E-R 图到表的映射，我们得到如下SQL

```sql
select * from class
order by c_id desc;
```

执行这个结果我们会得到如下结果

![](/images/articles/noob-learn-sql/03-order-01.jpeg)

大家可以将 `desc` 改变成 `asc` 查看一下效果



## 查询班级的标识 id、名称、开班时间，按照开班时间先后排列，开班时间相同的标识 id 倒序返回

> 分析：查询班级的标识 id、名称、开班时间，按照开班时间倒序，开班时间相同的标识 id 倒序返回
>
> 1. 查询：select
> 2. 到哪里取数据：**班级**
> 3. 得到哪些信息(列)：标识 id、名称、开班时间
> 4. 排序字段1：开班时间  -> 正序
> 5. 排序字段2：标识 id  -> 倒序
> 6. 取多少数据：**所有班级** （没有`limit`）
>
> 我们将这些信息套入到 SELECT 语句结构会得到如下：
>
> > **select 标识 id, 名称, 开班时间  from 班级**
> >
> > **order by 开班时间  正序, 标识 id 倒序;**

现在结合E-R 图到表的映射，我们得到如下SQL

```sql
select c_id,c_name,c_start_time from class
order by c_start_time asc, c_id desc;
```

执行这个结果我们会得到如下结果

![](/images/articles/noob-learn-sql/03-order-02.jpeg)

> 当使用多个列排序的时候，排序的处理顺序是从左到右，对于左边列值相同的行数据才会使用后面的列对其排序操作。

试试（综合实例）

- [ ] 查询结束时间最早的 10 个班级的标识 id、名称、开班时间、结束时间；如果结束时间相同，就返回开发时间最好的；如果结束时间和开班时间都相同，就返回标识 id 最大的。查询结果应该如下：

![](/images/articles/noob-learn-sql/03-order-03.jpeg)

- [ ] 按每页6条数据查询第 3 页班级信息，按照创建时间最大的排在前面，如果创建时间一样就按照 班主任 信息顺序排列。查询结果应该如下：

  ![](/images/articles/noob-learn-sql/03-order-04.jpeg)

# 总结

* SELECT 语句基本基本结构
* 查询需求或问题分析方法：综合 **需求或问题描述**、**E-R 图** 和 **表结构** 3方信息实施从问题到可执行 SQL 的分析设计
* 查询单列、多列、所有列数据
* 使用 `limit` 子句限定返回结果集中的数据的数量(结果集大小)
* 使用关键字 `distinct` 进行查询结果去重，注意取重时是比较所有查询列
* 使用 `order by` 子句对结果进行排序，可以是单列或多列，每列可以指定自己的排序方式：正序(`asc`)或倒序(`desc`)

> 大家会发现我们这里交替出现 **属性**、**字段**、**列** 如果没有特殊说明，这三个词语表达的含义是一样的，都不是标识数据表列或 ER 图属性。