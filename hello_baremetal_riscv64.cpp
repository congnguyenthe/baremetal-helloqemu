/* VIRT_UART0 base address is 0x10000000 according to QEMU source code*/

#include <algorithm>
#include <list>

#define VIRT_UART0 0x10000000

volatile unsigned int * const UART0DR = (unsigned int *)VIRT_UART0;

/* Until we reach to the end of the string, put each char on UART0 */
void print_uart0(const char *str) {
  while(*str != '\0') {
    *UART0DR = (unsigned int)(*str);
    str++;
  }
}

int c_entry() {
  std::list<int> my_list = { 12, 5, 10, 9 };
  for (int x : my_list) {
    print_uart0(x);
    print_uart0('\n');
  }
}
