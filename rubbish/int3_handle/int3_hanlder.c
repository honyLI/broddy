#include <linux/module.h>
#include <linux/kernel.h>
#include <linux/interrupt.h>
#define INT3_VECTOR 3

static irqreturn_t int3_handler(int irq, void *dev_id) {
    printk("Received int3 interrupt\n");
    // Handle int3 error here
    //return IRQ_HANDLED;
    return IRQ_NONE;

}

static int __init int3_init(void) {
    int ret;

    printk("Registering int3 handler\n");

    //ret = request_irq(INT3_VECTOR, int3_handler, 0, "int3_handler", NULL);
    set_system_gate(3,&int3_handler);
    if (ret) {
        printk(KERN_ERR "Failed to register int3 handler\n");
        return ret;
    }

    return 0;
}

static void __exit int3_exit(void) {
    printk("Unregistering int3 handler\n");

    //free_irq(INT3_VECTOR, NULL);
}

module_init(int3_init);
module_exit(int3_exit);

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Your Name");
