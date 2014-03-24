#!/bin/bash

TODO_DIR=$HOME/.vim-airline-todo  #you can set your own todo directory
[ ! -d $TODO_DIR ] && mkdir $TODO_DIR


case $1 in
    "list")
        ls -tr "$TODO_DIR" | head -$2
        ;;
    "count_done")
        ls $TODO_DIR | grep -E "^\[√" |  wc -l
        ;;
    "count_undone")
        ls $TODO_DIR | grep -vE "^\[√" |  wc -l
        ;;
    "done")
        ls $TODO_DIR | grep -E "^$2$" 
        if [ $? -ne 0 ];then
            echo "no such task"
        else
            mv $TODO_DIR/"$2" $TODO_DIR/"[√]$2"
        fi
        ;;
    "new")
        ls $TODO_DIR | grep -iE "^$2$" 
        if [ $? -ne 0 ];then
            echo "task alreay existed"
        else
            touch $TODO_DIR/"$2"
        fi
        ;;
    *)
        echo "
        count_done         show the count of done tasks
        count_undone       show the count of undone tasks
        done  [task_name]  mark the special task as done 
        list  [count]      show the tasks of special count, count is optional
        new   [task_name]  create a task with special name"
        ;;
esac
