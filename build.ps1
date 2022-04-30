$nameString=$args[0]
nasm .\src\boot\boot.s -o .\send\$nameString.bin
qemu-system-x86_64 .\send\$nameString.bin