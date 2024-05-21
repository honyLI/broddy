
#ifndef _UTIL_H
#define _UTIL_H

#ifndef offsetof
#define offsetof(TYPE, MEMBER) ((unsigned long) &((TYPE*)0)->MEMBER)
#endif

#define container_of(ptr, type, member) \
        ((type *)(((char *)(ptr)) - offsetof(type,member)))


#ifndef PAGE_SIZE
#define PAGE_SIZE 4096
#define PAGE_MASK (~(PAGE_SIZE - 1))
#define PAGE_SHIFT 12
#endif
#define ROUND_DOWN(x, m) ((x) & ~((m) - 1))
#define ROUND_UP(x, m) (((x) + (m) - 1) & ~((m) - 1))
#define ARRAY_SIZE(x)	(sizeof(x) / sizeof(x[0]))

#define proc2pctx(proc) list_first_entry(&(proc)->ptrace.pctxs,		\
					 struct ptrace_ctx, list)

#endif
