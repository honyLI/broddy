#include "block_list.h"
#include <time.h>

struct list_node *creatLink(){
    struct list_node* head=NULL;
    return head;
}//创建链表

int insertNode(struct list_node** head,unsigned long long insert_o_addr)//插入节点，插入失败则返回0，成功为1
{
    struct list_node* newlist_node=(struct list_node*)malloc(sizeof(struct list_node));
    if(newlist_node==NULL){
        printf("Memory allocation failed.\n");
        return 0;
    }
    newlist_node->o_addr=insert_o_addr;
    newlist_node->l_addr=0;
    newlist_node->size=0;

    if(*head==NULL){
        newlist_node->no=1;
        newlist_node->next=NULL;
        *head=newlist_node;
        return 1;
    }   
    struct list_node* temp=*head;
    while(temp->next!=NULL){
        temp=temp->next;
    }    
    newlist_node->no=temp->no+1;
    newlist_node->next=temp->next;
    temp->next=newlist_node;
    return 1;
}

int deletenode_no(struct list_node** head,int delete_no)//根据序号删除节点，成功返回1，失败返回0
{
    struct list_node* temp=*head,*prev=NULL;
    while(temp!=NULL&&temp->no!=delete_no){
        prev=temp;
        temp=temp->next;
    }
    if(temp==NULL) return 0;

    int no=temp->no;
    prev->next=temp->next;
    free(temp);
    prev=prev->next;
    while(prev!=NULL){
        prev->no=no++;
        prev=prev->next;
    }
    return 1;
}

int deletenode_addr(struct list_node** head,unsigned long long delete_o_addr)//根据原地址删除节点，成功返回1，失败返回0
{
    struct list_node* temp=*head,*prev=NULL;
    while(temp!=NULL&&temp->o_addr!=delete_o_addr){
        prev=temp;
        temp=temp->next;
    }
    if(temp==NULL) return 0;

    int no=temp->no;
    prev->next=temp->next;
    free(temp);
    prev=prev->next;
    while(prev!=NULL){
        prev->no=no++;
        prev=prev->next;
    }
    return 1;
}

int deletenode_expand(struct list_node** head,unsigned long addr,unsigned long sz)//根据原地址删除节点，成功返回1，失败返回0
{
    struct list_node* temp=*head,*prev=NULL;
    prev=temp;
    temp = temp->next;
    while(temp != NULL && abs(temp->o_addr - addr) > 128 ){
        prev=temp;
        temp=temp->next;
    }
    if(temp==NULL) return 0;
    while(temp != NULL && abs(temp->o_addr - addr) <= sz+3 ){
        int no = temp->no;
        prev->next=temp->next;
        prev->size += temp->size;
        free(temp);
        temp = prev->next;
        while(temp!=NULL){
            temp->no=no++;
            temp=temp->next;
        }
        temp = prev->next;

    }
    return 1;
}

unsigned long long o_inquiry(struct list_node** Linklist,int inquiry_no)//根据序号查询原地址，查到返回1，否则返回0
{
    struct list_node* temp=*Linklist;
    while(temp!=NULL&&temp->no!=inquiry_no){
        temp=temp->next;
    }
    if(temp==NULL){
        printf("查询结果不存在\n");
        return 0;
    }
    return temp->o_addr;
}//给一个序号查询，若为0，则没查到,否则返回代码块原地址

unsigned long long l_inquiry(struct list_node** Linklist,int inquiry_no)//根据序号查询新地址，查到返回1，否则返回0
{
    struct list_node* temp=*Linklist;
    while(temp!=NULL&&temp->no!=inquiry_no){
        temp=temp->next;
    }
    if(temp==NULL){
        printf("查询结果不存在\n");
        return 0;
    }
    return temp->l_addr;
}

void traverseList(struct list_node** Linklist)//遍历链表
{
    struct list_node* temp=*Linklist;
    while(temp!=NULL){
        printf("no:%d,o_addr:%llx,size:%ld,laddr:%lx\n", temp->no,temp->o_addr,temp->size,temp->l_addr);
        temp=temp->next;
    }
}

int get_list_length(struct list_node* head) {
    int length = 0;
    struct list_node* current = head;
    while (current != NULL) {
        length++;
        current = current->next;
    }
    return length;
}


int Inspect_order(struct list_node *head){
    struct list_node *temp=head;
    int no=1;
    while(temp!=NULL){
        if(temp->no!=no)
        {
            return 1;
        }
        temp=temp->next;
        no++;
    }
    return 0;
}

void random_swap1(struct list_node* head) {
    int length=get_list_length(head);

    if (head == NULL || head->next == NULL)
        return;

    for (int i = 0; i < length - 1; i++) {
        struct timeval tv;
        gettimeofday(&tv, NULL);
        unsigned int seed = tv.tv_sec * 1000 + tv.tv_usec / 1000;
        srand(seed);
        int rand_index =rand() % length;
        struct list_node *current = head->next;
        struct list_node *prev_current = head;

        for (int j = 1; j < rand_index; j++) {
            prev_current = current;
            current = current->next;
        }

        prev_current->next = current->next;
        current->next = head->next;
        head->next = current;
    }
}

void random_swap(struct list_node* head) {
    while(!Inspect_order(head)){
        random_swap1(head);
    }
}

void cal_size(struct list_node* head){
    struct list_node* temp=head;
    while(temp->next!=NULL){
        temp->size=temp->next->o_addr-temp->o_addr;
        temp=temp->next;
    }
}

void cal_laddr(struct list_node* head){
    struct list_node* temp=head;
    while(temp->next!=NULL){
        temp->next->l_addr=temp->l_addr+temp->size;
        temp=temp->next;
    }
}

void delete_last(struct list_node* head){
    struct list_node* temp=head,*prev=NULL;
    while(temp->next!=NULL){
        prev=temp;
        temp=temp->next;
    }
    free(temp);
    prev -> next = NULL;
}

void printListToFile(struct list_node* head, const char* file) {
    FILE* fp = fopen(file, "w");
    if (fp == NULL) {
        printf("Error opening file.\n");
        return;
    }
    struct list_node *temp=head;
    
    while (temp != NULL) {
        fprintf(fp, "%d %lx %lx %lx\n", temp->no, temp->o_addr, temp->l_addr, temp->size);
        temp = temp->next;
    }

    fclose(fp); 
}