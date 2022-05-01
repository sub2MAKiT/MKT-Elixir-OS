extern void screenRender() {
    char renderbuffer[2000];
    *renderbuffer = 0x10000;
    char * colour = 0xfffe;
    char * colourSelected = 0xfffd;
    for(int i = 0; i < 4000; i++,i++)
    {
        *(char*)(0xb8000 + i) = renderbuffer[i];
        if(renderbuffer[i] < 0)
            *(char*)(0xb8000 + i + 1) = *colourSelected;
        else
            *(char*)(0xb8000 + i + 1) = *colour;
    }
    return;
}