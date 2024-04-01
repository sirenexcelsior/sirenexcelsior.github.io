---
layout: post
title: Linux Basic Command Manual
description: Chapter 1 of Linux Trivia
tags: Linux NeuralNetwork 
categories: Notebooks
giscus_comments: True
date: 2024-04-1
featured: true
related_posts: true
toc:
  sidebar: left
---

```yml
toc:
  sidebar: left
```

## File and directory operations
- **`ls`** - **List**: This command lists the contents of a directory. The name "list" succinctly describes its primary function, which is to display files and directories.

  ```bash
  ls			# list the contents of a directory
  ls -l			# show detailed information
  ls -a			# show hidden files
  ```

- **`cd`** - **Change Directory**: The `cd` command is used to change the current working directory in a shell. The term "change directory" directly reflects its purpose of moving from one directory to another.

  ```bash
  cd /path/to/directory			# switch to the specified directory
  cd ..			# to return to parent directory
  cd ./path			# switch to the specified directory within the current directory
  ```

  

- **`pwd`** - **Print Working Directory**: This command outputs the full pathname of the current working directory. "Print working directory" accurately describes the action of displaying the directory you're currently in.

  ```bash
  pwd			# display the full path of the current directory
  ```

  

- **`mkdir`** - **Make Directory**: The `mkdir` command creates a new directory. The name "make directory" is a straightforward indication of its function to create (or "make") a new directory.

  ```bash
  mkdir new_directory			# creating a new catalogue
  ```

  

- **`rmdir`** - **Remove Directory**: This command is used to delete empty directories. The name "remove directory" clearly states that it removes directories, emphasizing that it only works on empty ones.

  ```bash
  rmdir directory_name			# delete empty directories
  ```

  

- **`rm`** - **Remove**: Unlike `rmdir`, the `rm` command is used to remove files or directories (the latter requires an option to do so recursively). The term "remove" is generic because it applies to both files and directories.

  ```bash
  rm file_name			# delete a file
  rm -r directory_name			# recursive deletion of directories and their contents
  ```

  

- **`cp`** - **Copy**: The `cp` command is used to copy files and directories. The term "copy" directly reflects its purpose to duplicate files or directories from one location to another.

  ```bash
  cp /source /destination			# copy the source file to the target location
  ```

  

- **`mv`** - **Move**: This command moves or renames files and directories. The name "move" is apt because it can move files or directories to a new location or simply rename them within their current directory.

  ```bash
  mv /source /destination			# moving or renaming files or directories
  ```

  
