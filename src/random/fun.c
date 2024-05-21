#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdbool.h>
#include <unistd.h>
#include "block_list.h"
char * table[] = {"jmpq"};
char * table_correction[] = {"call","rip","jmp","jle","jne","jbe",
                            "je","jg","ja","jl","jns","jae"};
unsigned long short_table[] = {0xeb,0xe3,0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77,
                                0x78,0x79,0x7a,0x7b,0x7c,0x7d,0x7e,0x7f};

bool find_short( const unsigned long op){
    for(int i=0;i<sizeof(short_table) / sizeof(short_table[0]); i++){
        if(short_table[i] == op){
            return true;
        }
    }
    return false;
}

char* find_correction(const char* line) {
    for (int i = 0; i < sizeof(table_correction) / sizeof(table_correction[0]); i++) {
        if (strstr(line, table_correction[i]) != NULL) {
            return strstr(line, table_correction[i]);
        }
    }
    return NULL;
}

char* find_jmp(const char* line) {
    for (int i = 0; i < sizeof(table) / sizeof(table[0]); i++) {
        if (strstr(line, table[i]) != NULL) {
            return strstr(line, table[i]);
        }
    }
    return NULL;
}

int main(){
    FILE * fp = popen("objdump -d /home/work/code/src/test/a.out", "r");
    FILE * func_table = fopen("/home/work/code/src/table/func_table","r");
    int result = open("result",O_RDWR | O_CREAT);
    char line[256];
    struct list_node* list = creatLink();
    unsigned long long start_addr = 0;
    unsigned long long end_addr = 0;
    if (fp == NULL) {
        perror("popen");
        return 1;
    }
    while(fgets(line,sizeof(line),func_table)){
        char * ptr = strstr(line,"fun2");
        if(ptr == NULL) continue;
        sscanf(line, "%*s %llx %llx", &start_addr, &end_addr);
    }
    /*录入首地址和模块*/
    insertNode(&list,start_addr);
    while(fgets(line,sizeof(line),fp)){
        unsigned long long address = 0;
        unsigned long op;
        sscanf(line, "%llx: %lx", &address, &op);
        if(address < start_addr) continue;
        if(address > end_addr) break;
        char *ptr1 = find_jmp(line);
        if(ptr1 == NULL) continue;
        char *l = strchr(line, ':');
        if(l>ptr1) continue;
        //printf("%s",line);
        
        fgets(line,sizeof(line),fp);
        sscanf(line, "%llx: %lx", &address, &op);
        insertNode(&list,address);
        //printf("%s",line);
    }
    insertNode(&list,end_addr);
    cal_size(list);
    delete_last(list);
    traverseList(&list);
    printf("--------------------------\n");
    /*扩大代码块*/
    fp = popen("objdump -d /home/work/code/src/test/a.out", "r");
    while(fgets(line,sizeof(line),fp)){
        unsigned long long address = 0;
        unsigned long op;
        sscanf(line, "%llx: %lx", &address, &op);
        if(address < start_addr) continue;
        if(address > end_addr) break;
        char *ptr1 = find_correction(line);
        if(ptr1 == NULL) continue;
        char *l = strchr(line, ':');
        if(l>ptr1) continue;
        if(find_short(op)){
            //fgets(line,sizeof(line),fp);
            unsigned number;
            sscanf(line, "%llx: %lx %x", &address, &op,&number);
            //printf("address:%lx op:%x number:%lx\n",address,op,number);
            deletenode_expand(&list,address,number);
        }
    }

    cal_size(list);
    list->l_addr = start_addr;
    /*打乱顺序*/
    random_swap(list);
    cal_laddr(list);    
    traverseList(&list);
    printListToFile(list, "/home/work/code/src/table/list_table");
    /*begin to copy the code*/
    struct list_node *temp = list;
    int exe = open("/home/work/code/src/test/a.out",O_RDWR);
    unsigned long buffer[10000];
    while(temp != NULL){
        pread(exe,buffer,temp->size,temp->o_addr);
        pwrite(result,buffer,temp->size,temp->l_addr);
        memset(buffer,0,sizeof(buffer));
        temp = temp->next;
        //printf("%lx\n",buffer[0]);
    }
    /*correct the jmp address*/
    fp = popen("objdump -d /home/work/code/src/test/a.out", "r");
    temp = list;
    while(fgets(line,sizeof(line),fp)){
        unsigned address = 0;
        unsigned long op1,op2;
        unsigned buf;
        sscanf(line, "%x: %lx %lx", &address, &op1,&op2);
        if(address < start_addr) continue;
        if(address > end_addr) break;
        char *ptr1 = find_correction(line);
        if(ptr1 == NULL) continue;
        char *l = strchr(line, ':');
        if(l>ptr1) continue;
        /*key steps*/
        temp = list;
        switch (op1){
            case 0x70:
            case 0x71:
            case 0x72:
            case 0x73:
            case 0x74:
            case 0x75:
            case 0x76:
            case 0x77:
            case 0x78:
            case 0x79:
            case 0x7a:    
            case 0x7b:
            case 0x7c:
            case 0x7d:
            case 0x7e:
            case 0x7f:
                continue;
            break;
            case 0x0f:
                switch(op2){
                    case 0x80:
                    case 0x81:
                    case 0x82:
                    case 0x83:
                    case 0x84:
                    case 0x85:
                    case 0x86:
                    case 0x87:
                    case 0x88:
                    case 0x89:
                    case 0x8a:
                    case 0x8b:
                    case 0x8c:
                    case 0x8d:
                    case 0x8e:
                    case 0x8f:
                        pread(exe,&buf,sizeof(buf),address+2);
                        while(temp != NULL){
                            if(temp->o_addr <= address+buf+6 && temp->o_addr + temp->size > address+buf+6){
                                buf = buf - temp->o_addr + temp->l_addr;
                                break;
                            }
                            temp = temp->next;
                        }
                        temp = list;
                        while(temp != NULL){
                            if(temp->o_addr <= address && temp->o_addr + temp->size > address){
                                buf = buf +temp->o_addr - temp->l_addr;
                                break;
                            }
                            temp = temp->next;
                        }
                        //printf("buf:%lx\n",buf);
                        //printf("buf_addr:%lx\n",address+2+temp->l_addr-temp->o_addr);
                        size_t bytes_written = pwrite(result,&buf,sizeof(buf),address+2+temp->l_addr-temp->o_addr);
                        if (bytes_written == -1){
                            perror("pwrite");
                        }
                        break;
                    default:
                        break;
                }
                break;
            case 0xe8:
                pread(exe,&buf,sizeof(buf),address+1);
                while(temp != NULL){
                    if(temp->o_addr <= address && temp->o_addr + temp->size > address){
                        buf = buf + temp->o_addr - temp->l_addr;
                        break;
                    }
                    temp = temp->next;
                }
                pwrite(result,&buf,sizeof(buf),address+1+temp->l_addr-temp->o_addr);
                break;
            case 0xe9:
                pread(exe,&buf,sizeof(buf),address+1);
                while(temp != NULL){ 
                    /*intra-function jump*/
                    if(temp->o_addr <= address+buf+5 && temp->o_addr + temp->size > address+buf+5){
                        buf = buf - temp->o_addr + temp->l_addr;
                        break;
                    }
                    temp = temp->next;
                }
                temp = list;
                while(temp != NULL){
                    if(temp->o_addr <= address && temp->o_addr + temp->size > address){
                        buf = buf + temp->o_addr - temp->l_addr;
                        break;
                    }
                    temp = temp->next;
                }
                //printf("buf:%lx\n",buf);
                //printf("buf_addr:%lx\n",address+2+temp->l_addr-temp->o_addr);
                size_t bytes_written = pwrite(result,&buf,sizeof(buf),address+1+temp->l_addr-temp->o_addr);
                if (bytes_written == -1){
                    perror("pwrite");
                }
                break;
            case 0x48:
                break;
            case 0xf2:
                break;
            case 0x8b:
                break;
            case 0x89:
                break;
            default:
                break;
        }

        if(op1 == 0x48){  //48 8d 3d d4 0b 00 00 	lea    0xbd4(%rip),%rdi
            pread(exe,&buf,sizeof(buf),address+3);
            while(temp != NULL){
                if(temp->o_addr <= address && temp->o_addr + temp->size > address){
                    buf = buf + temp->o_addr - temp->l_addr;
                    break;
                }
                temp = temp->next;
            }
            pwrite(result,&buf,sizeof(buf),address+3+temp->l_addr-temp->o_addr);
            
        }else if(op1 == 0xf2){  //bnd jmp
            if(op2 == 0xe9){    //bnd jmpq 1020 <.plt>
                pread(exe,&buf,sizeof(buf),address+2);
                while(temp != NULL){
                    if(temp->o_addr <= address && temp->o_addr + temp->size > address){
                        buf = buf + temp->o_addr - temp->l_addr;
                        break;
                    }
                    temp = temp->next;
                }
                pwrite(result,&buf,sizeof(buf),address+2+temp->l_addr-temp->o_addr);
            }
            if(op2 == 0xff){    //bnd jmpq *0x17fe3(%rip) 
                pread(exe,&buf,sizeof(buf),address+3);
                while(temp != NULL){
                    if(temp->o_addr <= address && temp->o_addr + temp->size > address){
                        buf = buf + temp->o_addr - temp->l_addr;
                        break;
                    }
                    temp = temp->next;
                }
                pwrite(result,&buf,sizeof(buf),address+3+temp->l_addr-temp->o_addr);
            }
        }
        else if(op1 == 0x8b){  //mov
            if(op2 == 0x05 || op2 == 0x15){    //mov
                pread(exe,&buf,sizeof(buf),address+2);
                while(temp != NULL){
                    if(temp->o_addr <= address && temp->o_addr + temp->size > address){
                        buf = buf + temp->o_addr - temp->l_addr;
                        break;
                    }
                    temp = temp->next;
                }
                pwrite(result,&buf,sizeof(buf),address+2+temp->l_addr-temp->o_addr);
            }
        }
        else if(op1 == 0x89){   //mov
            if(op2 == 0x05){    //mov
                pread(exe,&buf,sizeof(buf),address+2);
                while(temp != NULL){
                    if(temp->o_addr <= address && temp->o_addr + temp->size > address){
                        buf = buf + temp->o_addr - temp->l_addr;
                        break;
                    }
                    temp = temp->next;
                }
                pwrite(result,&buf,sizeof(buf),address+2+temp->l_addr-temp->o_addr);
            }
        }
    }


    close(exe);
    close(result);    
    pclose(fp);
    fclose(func_table);

}