char * colorThemeHigh;
char * colorThemeLow;

extern void * MKTalloc(int bytes)
{
    int * theBest = 0x8001;
    int * vrmSize = 0x8005;
    int * MKTRam = 0x8009;
    int * MKTRamSizeVariable = 0x10000;
    int tempAddr = *theBest;
    while(tempAddr < 0x12000||((tempAddr+bytes>0xb8000||tempAddr>0xb8000)&&tempAddr<0xb87d0))
    {
        for(int i = 0;i < *vrmSize;i++)
        {
            if(!((tempAddr+bytes < MKTRam[i])||(tempAddr>MKTRam[i]+MKTRamSizeVariable[i])))
            {
                tempAddr += bytes;
                i = 0;
            }
        }
        tempAddr += bytes;
    }
    *vrmSize++;
    MKTRam[*vrmSize] = tempAddr;
    *theBest = tempAddr+bytes+1;
    return tempAddr;
}

extern void MKTfree(void * ptr)
{
    int * vrmSize = 0x8005;
    int * MKTRam = 0x8009;
    char * MKTRamSizeVariable = 0x10000;
    for(int i = 0; i < vrmSize;i++)
    {
        if(ptr == MKTRam[i])
        {
            for(int a = i+1; a < vrmSize;a++)
            {
                MKTRam[a-1] = MKTRam[a];
                MKTRamSizeVariable[a-1] = MKTRamSizeVariable[a];
            }
            *vrmSize--;
            return;
        }
    }
    return;
}

char * mallocTest;
extern void main() {
    mallocTest  = MKTalloc(1000);
    mallocTest[0] = 'M';
    mallocTest[1] = 'A';
    mallocTest[2] = 'K';
    mallocTest[3] = 'i';
    mallocTest[4] = 'T';
    for(int i = 5; i < 1000;i++)
    {
        mallocTest[i]='A';
    }
    char bootUpString[19] = "Welcome to ElixirOS";
    for(int i = 0;i < 38; i++,i++)
    {
        *(char*)(0xb8000 + i) = bootUpString[i/2];
        *(char*)(0xb8000 + i + 1) = 201;
    }
    for(int i = 0; i < 3962;i++)
    {
        *(char*)(0xb8000 + i*2 + 38) = i % 256;
        *(char*)(0xb8000 + i*2 + 39) = i % 256; //B87D0
    }
    int * tempTheBest = 0x8001;
    *tempTheBest = 0x12000;
    int * tempVrmSize = 0x8005;
    *tempVrmSize = 0;
    *colorThemeHigh = 154;
    *colorThemeLow = 105;
    extern char optionSelected;
    optionSelected = 0;
    return;
}


