extern void main() {
    char bootUpString[19] = "Welcome to ElixirOS";
    for(int i = 0;i < 38; i++,i++)
    {
        *(char*)(0xb8000 + i) = bootUpString[i/2];
        *(char*)(0xb8000 + i + 1) = 201;
    }
    for(int i = 0; i < 3962;i++)
    {
        *(char*)(0xb8000 + i + 38) = i % 256;
    }
    return;
}