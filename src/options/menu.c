char optionSelected;


extern void drawMenu()
{
    char * fileExplorerString = "file explorer";
    char webBrowserString[12] = "web browser";
    char calculatorString[11] = "calculator";
    char mediaString[6] = "media";
    char textEditorString[12] = "text Editor";

    short offset;
    offset = 0;

    extern char * colorThemeHigh;
    extern char * colorThemeLow;
    char colorThemeLowPointed = *colorThemeLow;
    char colorThemeHighPointed = *colorThemeHigh;


    magicCoolSpaceGenerator(&offset,960, colorThemeLowPointed);

    extern char * mallocTest;



    char * testForMalloc = MKTalloc(1);
    *testForMalloc = 'W';

    for(int i = 0; i < 1000;i++)
    {
        *(char*)(0xb8000 + i*2) = mallocTest[i];
        *(char*)(0xb8000 + i*2+1) = 201;
    }

    *(char*)(0xb8000 + 2002) = *testForMalloc;
    *(char*)(0xb8000 + 2003) = 201;

    MKTfree(testForMalloc);

    // magicCoolStringCosmicGenerator(&fileExplorerString, &offset,colorThemeLow);



    // magicCoolSpaceGenerator(&offset,960, colorThemeLowPointed);




    // for(int i = 0;i < 6;i++)
    // {
    //     *offset++;
    //     *offset++;
    //     *(char*)(0xb8000 + *offset) = 32;
    //     *(char*)(0xb8000 + *offset + 1) = *colorThemeLow;
    // }
    // addMenuString(fileExplorerString, 13, offset, (optionSelected==0)?*colorThemeHigh:*colorThemeLow);
    // for(int i = 0;i < 4;i++)
    // {
    //     *offset++;
    //     *offset++;
    //     *(char*)(0xb8000 + *offset) = 32;
    //     *(char*)(0xb8000 + *offset + 1) = *colorThemeLow;
    // }
    // addMenuString(webBrowserString, 11, offset, (optionSelected==1)?*colorThemeHigh:*colorThemeLow);
    // for(int i = 0;i < 4;i++)
    // {
    //     *offset++;
    //     *offset++;
    //     *(char*)(0xb8000 + *offset) = 32;
    //     *(char*)(0xb8000 + *offset + 1) = *colorThemeLow;
    // }
    // addMenuString(calculatorString, 10, offset, (optionSelected==2)?*colorThemeHigh:*colorThemeLow);
    // for(int i = 0;i < 4;i++)
    // {
    //     *offset++;
    //     *offset++;
    //     *(char*)(0xb8000 + *offset) = 32;
    //     *(char*)(0xb8000 + *offset + 1) = *colorThemeLow;
    // }
    // addMenuString(mediaString, 5, offset, (optionSelected==3)?*colorThemeHigh:*colorThemeLow);
    // for(int i = 0;i < 4;i++)
    // {
    //     *offset++;
    //     *offset++;
    //     *(char*)(0xb8000 + *offset) = 32;
    //     *(char*)(0xb8000 + *offset + 1) = *colorThemeLow;
    // }
    // addMenuString(textEditorString, 11, offset, (optionSelected==4)?*colorThemeHigh:*colorThemeLow);
    // for(int i = 0;i < 6;i++)
    // {
    //     *offset++;
    //     *offset++;
    //     *(char*)(0xb8000 + *offset) = 32;
    //     *(char*)(0xb8000 + *offset + 1) = *colorThemeLow;
    // }




    // for(int i = 0;i < 960;i++)
    // {
    //     *offset++;
    //     *offset++;
    //     *(char*)(0xb8000 + *offset) = 32;
    //     *(char*)(0xb8000 + *offset + 1) = *colorThemeLow;
    // }
    return;
}

void magicCoolSpaceGenerator(short *offset, short spaces, char colorThemeLow)
{
    short b = *offset;
    for(short i = b;i < b + spaces;i++)
    {
        *(char*)(0xb8000 + i*2) = 32;
        *(char*)(0xb8000 + i*2 + 1) = colorThemeLow;
    } //top

    *offset += spaces;

    return;
}

void magicCoolStringCosmicGenerator(char * charArray, short *offset,char colorTheme)
{
    for(short i = 0;i < 14;i++)
    {
        // if(charArray[i] == 0)
            // return;
        *(char*)(0xb8000 + (i+*offset)*2) = charArray[i];
        *(char*)(0xb8000 + (i+*offset)*2 + 1) = colorTheme;
        *offset++;
    }
    return;
}