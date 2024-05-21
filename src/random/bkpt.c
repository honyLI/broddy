#include<stdio.h>
#include"block_list.h"

char * bkpt_table_name = "/home/work/code/src/table/bkpt_table";
char * list_table_name = "/home/work/code/src/table/list_table";
struct list_node * list;

int init_list(void){
    char line[64];
    struct list_node *temp = list;
    FILE * list_table = fopen(list_table_name,"r");
    if (list_table == NULL) {
        printf("open list_table error\n");
        return -1;
    }

    /*let's read the block*/
    while (fgets(line, sizeof(line), list_table))
    {
        int no;
        unsigned long o_addr, l_addr,b_size;
        sscanf(line, "%d %lx %lx %lx",&no, &o_addr, &l_addr, &b_size);
        temp = malloc(sizeof(struct list_node));
        temp->no = no;
        temp->o_addr = o_addr;
        temp->l_addr = l_addr;
        temp->size = b_size;
        temp->next = NULL;
        //printk("%d %llx %llx %llx\n",temp->no, temp->o_addr, temp->l_addr, temp->size);
        if (list == NULL) {
            list = temp;
        } else {
            struct list_node *cur = list;
            while (cur->next != NULL) {
                cur = cur->next;
            }
            cur->next = temp;
        }
    }
    fclose(list_table);
    return 0;
}

void insert_break_point(unsigned long addr){
    struct list_node *temp = list;
    unsigned long long ori_off,bud_off;
    FILE * bkpt_table = fopen(bkpt_table_name,"w+");
    if (bkpt_table == NULL) {
        printf("open bkpt_table error\n");
        return 0;
    }
    while(temp){
        ori_off = temp->o_addr;
        bud_off = temp->l_addr - list->l_addr;
        fprintf(bkpt_table,"%llx %llx\n",ori_off,bud_off);
        temp = temp->next;
    }
    temp = list;
    while(temp){
        if(addr >= temp->o_addr && addr < temp->o_addr + temp->size){
            ori_off = addr;
            bud_off = addr - temp->o_addr +temp->l_addr - list->l_addr;
            fprintf(bkpt_table,"%llx %llx\n",ori_off,bud_off);
            break;
        }
        temp = temp->next;
    }

    fclose(bkpt_table);
}

void free_list(){
    struct list_node *cur = list;
    struct list_node *next;
    while (cur != NULL) {
        next = cur->next;
        free(cur);
        cur = next;
    }
    list = NULL;
}

int main(int argc,char ** argv){
    
    unsigned long addr = 0;
    
    if(argc > 1){
        sscanf(argv[1], "%lx", & addr);
    }
    init_list();
    insert_break_point(addr);

    free_list();
    return 0;
}