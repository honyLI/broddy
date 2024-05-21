#include <stdio.h>
#include <string.h>
#include <stdlib.h>
int main(){
    char dmp_name[] = "/home/work/code/src/test/test.s";
    FILE *dmp_file = fopen(dmp_name, "r");
    char table_name[] = "/home/work/code/src/table/func_table";
    FILE *table = fopen(table_name, "rw+");
    char call_name[] = "/home/work/code/src/table/call_table";
    FILE *call_table = fopen(call_name, "rw+");

    char line[512];
    char temp[128] = {'\0'};
    char addr[20];
    while (fgets(line, sizeof(line), dmp_file)){
        char *ptr = strstr(line, ">:");
        if (ptr == NULL) 
            continue;
        char * begin = strchr(line,'<');
        begin++;
        memset(addr, 0, sizeof(addr));//清空一下
        strncpy(addr,line,16);
        addr[16] = '\n';
        if(strlen(temp) != 0){
            strcat(temp, addr);
            fputs(temp,table);            
        }
        memset(temp, 0, sizeof(temp));//清空一下
        strncpy(temp,begin,ptr-begin);
        temp[ptr-begin] = ' ';           
        addr[16] = ' ';
        strcat(temp, addr);    
    }
    fclose(table);
    fclose(dmp_file);
    dmp_file = fopen(dmp_name, "r");
    while (fgets(line, sizeof(line), dmp_file)){
        char *ptr1 = strstr(line, "call");
        char *ptr2 = strstr(line, "rip");
        char *l = strchr(line, ':');
        if(ptr1 == NULL && ptr2 == NULL){
            continue;
        }
        if(l != NULL){
            line[l - line] = ' ';
        }
        fputs(line,call_table);
    }
    fclose(dmp_file);
    fclose(call_table);
}