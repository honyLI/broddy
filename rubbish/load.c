#include "load.h"
struct stat sb;
#define PAGE_SIZE	4096
#define ELF_MIN_ALIGN	PAGE_SIZE
#define ELF_PAGESTART(_v) ((_v) & ~(unsigned long)(ELF_MIN_ALIGN-1))
#define ELF_PAGEALIGN(_v) (((_v) + ELF_MIN_ALIGN - 1) & ~(ELF_MIN_ALIGN - 1))

#define ENOMEM 12
#define EFAULT 14

static inline int make_prot(int64_t p_flags)
{
	int prot = 0;

	if (p_flags & PF_R)
		prot |= PROT_READ;
	if (p_flags & PF_W)
		prot |= PROT_WRITE;
	if (p_flags & PF_X)
		prot |= PROT_EXEC;
	return prot;
}

static Elf64_Phdr *load_elf_phdrs(Elf64_Ehdr *elf_ex, int fd)
{
	Elf64_Phdr *elf_phdata = NULL;

	unsigned int size;

	size = sizeof(Elf64_Phdr) * elf_ex->e_phnum;

	elf_phdata = malloc(size);

	/* Read in the program headers */
    lseek(fd, elf_ex->e_phoff, SEEK_SET);
	read(fd, elf_phdata, size);

	return elf_phdata;
}


static unsigned long total_mapping_size(const Elf64_Phdr *cmds, int nr)
{
	int i, first_idx = -1, last_idx = -1;

	for (i = 0; i < nr; i++) {
		if (cmds[i].p_type == PT_LOAD) {
			last_idx = i;
			if (first_idx == -1)
				first_idx = i;
		}
	}
	if (first_idx == -1)
		return 0;

	return cmds[last_idx].p_vaddr + cmds[last_idx].p_memsz -
				ELF_PAGESTART(cmds[first_idx].p_vaddr);
}


static unsigned long load_elf_interp(Elf64_Ehdr *interp_elf_ex,
		int interp_fd, unsigned long *interp_map_addr, Elf64_Phdr *interp_elf_phdata)
{
	Elf64_Phdr *eppnt;
	unsigned long load_addr = 0;
	int load_addr_set = 0;
	unsigned long last_bss = 0, elf_bss = 0;
	int bss_prot = 0;
	unsigned long error = ~0UL;
	unsigned long total_size;
	int i;

	total_size = total_mapping_size(interp_elf_phdata,
					interp_elf_ex->e_phnum);

	eppnt = interp_elf_phdata;
	for (i = 0; i < interp_elf_ex->e_phnum; i++, eppnt++) {
		if (eppnt->p_type == PT_LOAD) {
			int elf_type = MAP_PRIVATE | MAP_DENYWRITE;
			int elf_prot = make_prot(eppnt->p_flags);
			unsigned long vaddr = 0;
			unsigned long k, map_addr;

			vaddr = eppnt->p_vaddr;
			if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
				//elf_type |= MAP_FIXED_NOREPLACE;
                k=0;

			//map_addr = elf_map(interp_fd, load_addr + vaddr,
			//		eppnt, elf_prot, elf_type, total_size);
            map_addr = mmap(load_addr + vaddr,total_size,elf_type,elf_type,interp_fd,0);
			total_size = 0;
			if (!*interp_map_addr)
				*interp_map_addr = map_addr;
			error = map_addr;

			if (!load_addr_set &&
			    interp_elf_ex->e_type == ET_DYN) {
				load_addr = map_addr - ELF_PAGESTART(vaddr);
				load_addr_set = 1;
			}

			/*
			 * Check to see if the section's size will overflow the
			 * allowed task size. Note that p_filesz must always be
			 * <= p_memsize so it's only necessary to check p_memsz.
			 */
			if (eppnt->p_filesz > eppnt->p_memsz) {
				error = -ENOMEM;
				return error;
			}

			/*
			 * Find the end of the file mapping for this phdr, and
			 * keep track of the largest address we see for this.
			 */
			k = load_addr + eppnt->p_vaddr + eppnt->p_filesz;
			if (k > elf_bss)
				elf_bss = k;

			/*
			 * Do the same thing for the memory mapping - between
			 * elf_bss and last_bss is the bss section.
			 */
			k = load_addr + eppnt->p_vaddr + eppnt->p_memsz;
			if (k > last_bss) {
				last_bss = k;
				bss_prot = elf_prot;
			}
		}
	}

	/*
	 * Now fill out the bss section: first pad the last page from
	 * the file up to the page boundary, and zero it from elf_bss
	 * up to the end of the page.
	 */
    /*
	if (padzero(elf_bss)) {
		error = -EFAULT;
		return error;
	}
    */
	/*
	 * Next, align both the file and mem bss up to the page size,
	 * since this is where elf_bss was just zeroed up to, and where
	 * last_bss will end after the vm_brk_flags() below.
	 */
	elf_bss = ELF_PAGEALIGN(elf_bss);
	last_bss = ELF_PAGEALIGN(last_bss);
	/* Finally, if there is still more bss to allocate, do it. */
    /*
	if (last_bss > elf_bss) {
		error = vm_brk_flags(elf_bss, last_bss - elf_bss,
				bss_prot & PROT_EXEC ? VM_EXEC : 0);
		if (error)
			return error;
	}*/

	return load_addr;
}




Elf64_Ehdr* loadelf(int fd){

    // 获取文件的大小
    if (fstat(fd, &sb) == -1) {
        perror("fstat");
        return 0;
    }

    Elf64_Ehdr* map_addr = mmap(NULL, sb.st_size, PROT_EXEC | PROT_READ, MAP_PRIVATE, fd, 0);
    Elf64_Ehdr* interp_ehdr; //解释器的elf头
    Elf64_Phdr* interp_phdr; //解释器程序头表 
    interp_ehdr = malloc(sizeof(*interp_ehdr));
    interp_phdr = malloc(sizeof(*interp_phdr));
    Elf64_Phdr* map_phdr; //程序头表
    Elf64_Ehdr* start;
    int inter; //解释器的文件描述符
    map_phdr = load_elf_phdrs(map_addr,fd);
    Elf64_Phdr *map_ppnt = map_phdr;

    for(int i=0;i<map_addr->e_phnum;i++ , map_ppnt++){
        if(map_ppnt->p_type != PT_INTERP) 
            continue;
        //找到解释器了奥兄弟们
        printf("好好好:%d\n",i);
        char * interpreter = malloc(map_ppnt->p_filesz);
        lseek(fd, map_ppnt->p_offset, SEEK_SET);
	    read(fd, interpreter, map_ppnt->p_filesz);
        //已经把解释器拿到了好像
        inter = open(interpreter , O_RDONLY);//内核里是open_exec,不知道有没有影响
        free(interpreter);
        read(inter,interp_ehdr,sizeof(*interp_ehdr));
        //现在已经读入了解释器的elf文件头，放在interp，应该是128字节
        break;
    }

    map_ppnt = map_phdr;

    if(inter){
        //装入解释器的程序头
        interp_phdr = load_elf_phdrs(interp_ehdr,inter);
    }
	for(int i = 0; i < map_addr->e_phnum; i++, map_ppnt++) {
        if (map_ppnt->p_type != PT_LOAD)
		    continue;
        int flags = MAP_PRIVATE | MAP_DENYWRITE | MAP_EXECUTABLE;
        int size;
        size = total_mapping_size(map_phdr , map_addr->e_phnum);
        //size = 4096000;
        start = mmap(NULL,size,PROT_EXEC | PROT_READ,flags,fd,0);
    }
	
    if(inter){
        unsigned long interp_map_addr = 0;
        load_elf_interp(interp_ehdr, inter, &interp_map_addr, interp_phdr);

    }
	




    free(interp_ehdr);
    free(interp_phdr);
    free(map_phdr);
    //return map_addr;
    munmap(map_addr, sb.st_size) ;
    return start;
}


int unload(Elf64_Ehdr* map_addr){
    return munmap(map_addr, sb.st_size) ;
}

