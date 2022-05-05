echo started building

/usr/local/i386elfgcc/bin/i386-elf-gcc -ffreestanding -m32 -g -c "./src/kernel/kernel.c" -o "./unlinked/kernel.o"
/usr/local/i386elfgcc/bin/i386-elf-gcc -ffreestanding -m32 -g -c "./src/options/menu.c" -o "./unlinked/menu.o"
nasm "./src/kernel/kernelEntry.s" -f elf -o "./unlinked/kernelEntry.o"
nasm "./src/boot/boot.s" -o "./unlinked/bin/boot.bin"

echo finished building


echo started linking 

/usr/local/i386elfgcc/bin/i386-elf-ld -o "./unlinked/bin/fullKernel.bin" -Ttext 0x1000 "./unlinked/kernelEntry.o" "./unlinked/menu.o" "./unlinked/kernel.o" --oformat binary

echo finished linking


echo started concating

cat "./unlinked/bin/boot.bin" "./unlinked/bin/fullKernel.bin" > "./versions/0007.bin"

echo finished concating