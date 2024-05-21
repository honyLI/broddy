#ifndef LIST_OPERATIONS_H
#define LIST_OPERATIONS_H

#include <stdio.h>
#include <stdlib.h>

struct list_node
{
    int no;
    unsigned long long o_addr;
    unsigned long long l_addr;
    size_t size;
    struct list_node *next;
};

struct list_node *creatLink();
int insertNode(struct list_node** head,unsigned long long insert_o_addr);
int deletenode_no(struct list_node** head,int delete_no);
int deletenode_addr(struct list_node** head,unsigned long long delete_o_addr);
int deletenode_expand(struct list_node** head,unsigned long addr,unsigned long sz);
unsigned long long o_inquiry(struct list_node** Linklist,int inquiry_no);
unsigned long long l_inquiry(struct list_node** Linklist,int inquiry_no);
void traverseList(struct list_node** Linklist);
void random_swap(struct list_node* head);
int get_list_length(struct list_node* head);
void cal_size(struct list_node* head);
void cal_laddr(struct list_node* head);
void delete_last(struct list_node* head);
void printListToFile(struct list_node* head, const char* file);
#endif