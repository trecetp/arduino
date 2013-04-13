/*
A sudoku is a special arrangement of a 9 X 9 box of the numbers 123456789.

641.597.238    each row has 123456789
273.681.945 
589.324.716    each column has 123456789
........... 
836.952.471    each 3X3 box has 123456789
127.438.569 
954.716.382
........... 
492.863.157    when we start with a blank sudoku each number can be 12345678.
318.275.694    So to describe a sudoku we must have 9x9x9 = 729 characters.
765.149.823
*/

/*
Move the pionter using left,right,up and down buttons.

Fire button with pointer over EASY, MED or HARD to start a easy,medium or hard sudoku.

Fire button over column of select 123456789 numbers to select the number you
wish to enter into the sudoku.

Fire button over a sudoku position to enter the selected number.
If it cannot go in that position because it is not possible then it
will not be entered.

This does not save you from making long range mistakes.
If you make a wrong guess a "+" will show in a location.
This means there are no possible numbers for that location and the sudoku cannot
be solved.
*/

#include <SUDOKU.h>

#include <ButtonController.h>
#include <TVout.h>
#include <fontALL.h>
TVout TV;

char x = 0;  //the select x position 0 to 8
char y = 0;  //the select y position 0 to 8
char select = 0; //we can select the number from 1(0) to 9(8)
unsigned char control[5]; //the controls counts left,right,up,down,fire
unsigned char pointer[2] ={0,94};//the screen pointer X,Y
unsigned char Rpointer[2] ={0,94};//the old screen pointer X,Y
char sudoku[81];  //display array

//sudoku construction lines
const char ylines[14] = {0,1,11,21,31,32,42,52,62,63,73,83,93,94};
const char xlines[14] = {51,52,60,68,76,77,85,93,101,102,110,118,126,127};
//sudoku number positions
const char numberY[9] = {4,14,24,35,45,55,66,76,86};
const char numberX[9] = {55,63,71,80,88,96,105,113,121};

const char pointerspeed = 4;  //set this number to control pointer speed
char tvmode = _NTSC;

void setup()
{
    // If pin 12 is pulled LOW, then the PAL jumper is shorted.
    pinMode(12, INPUT);
    digitalWrite(12, HIGH);

    if (digitalRead(12) == LOW) {
      tvmode = _PAL;
    } else {
      tvmode = _NTSC;
    }

    TV.begin(tvmode,128,96);
    startup(45);  //start with an easy sudoku
}

void loop() 
{
 if (Controller.leftPressed()) 
{
  control[0] +=1;
  if(control[0] > pointerspeed) //is the push long enough
  {
  control[0] = 0; //reset the counter
  pointer[0] -=1; //move the pointer one left
  if(pointer[0] == 255) //are we at left side limit
  pointer[0]=0;//yes so leave pointer far left
  else //we have  0 to 127
  {
    printRpointer(); //restore old pointer
    printpointer(); //print this new pointer 
  }//end of in range 0 to 127
  }//end of we have a decent button push 
}//end of left pressed

if (Controller.rightPressed()) 
{
  control[1] +=1; //record the push state
  if(control[1] > pointerspeed) //is the push long enough
  {
  control[1] = 0; //reset the counter
  pointer[0] +=1; //move the pointer one right
  if(pointer[0] == 127) //are we at right side limit
  pointer[0]=126;//yes so leave pointer far right
  else //we have  0 to 127
  {     
    printRpointer(); //restore old pointer
    printpointer(); //print this new pointer   
  }//end of in range 0 to 127
  }//end of we have a decent button push 
}//end of right pressed

if (Controller.upPressed()) 
{
  control[2] +=1; 
  if(control[2] > pointerspeed) //is the push long enough
  {
  control[2] = 0; //reset the counter
  pointer[1] -=1; //move the pointer one up
  if(pointer[1] == 255) //are we at top limit
  pointer[1] = 0;//yes so leave pointer at top
  else //we have  0 to 95
  {
    printRpointer(); //restore old pointer
    printpointer(); //print this new pointer   
  }//end of in range 0 to 95
  }//end of we have a decent button push  
}//end of up pressed

if (Controller.downPressed()) 
{
  control[3] +=1;
  if(control[3] > pointerspeed) //is the push long enough
  {
  control[3] = 0; //reset the counter
  pointer[1] +=1; //move the pointer one down
  if(pointer[1] == 95) //are we at bottom limit
  pointer[1] = 94;//yes so leave pointer at botom
  else //we have  0 to 95
  {
    printRpointer(); //restore old pointer
    printpointer(); //print this new pointer   
  }//end of in range 0 to 95
  }//end of we have a decent button push  
}//end of down pressed

if(Controller.firePressed()) 
{
  control[4] +=1;
  if(control[4] > pointerspeed) //is the push long enough
  {  
  control[4] = 0; //reset the counter
  TV.tone(1046, 50);
  if((pointer[0] >= 0) && (pointer[0] <= 20))//we have a button push
  {
  if((pointer[1] >= 0) && (pointer[1] <= 10))//  is an easy selected
  startup(45); //run easy sudoku
  if((pointer[1] >= 20) && (pointer[1] <= 30))//  is a medium selected
  startup(35); //run medium sudoku
  if((pointer[1] >= 40) && (pointer[1] <= 50))//  is a hard selected
  startup(25); //run hard sudoku
  }//end of we have a function call
  
  else if((pointer[0] >= 32) && (pointer[0] <= 40) && (pointer[1] <= 89))//we have a number select
  {    
  for(char i = 0; i < 9; i++) //find the selected number
  {
   if((pointer[1] >= i*10) && (pointer[1] <= i*10 + 20))
   select = i;  //this is it 
  }//end of find which number is selected
  printpointer();  //remove the current pointer
  for (char i = 0; i < 9; i++)
    {
      TV.draw_rect(33,1 + i*10,6,8,BLACK,BLACK);//clear the selection numbers
      TV.print_char(35,3 + i*10,i + 0x31); //store the selection numbers
    }//end of store numbers in number select
  TV.draw_rect(33,1 + select*10,6,8,WHITE,INVERT);//show which number is selected
  printpointer();  //reload the current pointer
  }//end of we have a number select
  
  else if((pointer[0] >= 51) && (pointer[0] <= 127))//we have a sudoku entry
  {
   for(char i = 0; i < 9; i++) //find the selected X value
  {
   if((pointer[0] >= numberX[i] - 3) && (pointer[0] <= numberX[i] + 4))
   x = i;  //this is it 
  }//end of find which X value is selected
  
  for(char i = 0; i < 9; i++) //find the selected Y value
  {
   if((pointer[1] >= numberY[i] - 3) && (pointer[1] <= numberY[i] + 6))
   y = i;  //this is it 
  }//end of find which Y value is selected
   setnumber(x,y,select);
   printpointer();  //remove the current pointer
   printdisplay(); //show the updates
   printpointer();  //reload the current pointer
  }//end of we have a sudoku entry
  }//end of we have a decent button push   
}//end of fire pressed

TV.delay(1);
}//end of loop

void startup(char level)
{
    TV.clear_screen();
    TV.select_font(font6x8);
    TV.println("  Generating Sudoku");
    TV.println(" ");
    TV.println("  Transmission should ");
    TV.println("  resume in less than ");
    TV.println("  20 seconds ");
    TV.delay(3000); //print information screen before calculating sudoku
    TV.end();  //free up RAM used for display and disable sync
    SUDOKU.generate(level); //uses most of RAM. compiler free's up on return
    TV.begin(tvmode,128,96);
    TV.select_font(font4x6);
    pointer[0] = 0;
    pointer[1] = 94; //reset pointer
    refresh();  //print game outline
    printdisplay(); // print the selected sudoku numbers        
}//end of start the sudoku program

void printRpointer(void)
{
    TV.set_pixel(Rpointer[0],Rpointer[1],INVERT); //draw the pointer 
    TV.set_pixel(Rpointer[0],Rpointer[1] + 1,INVERT); //draw the pointer  
    TV.set_pixel(Rpointer[0] + 1,Rpointer[1],INVERT); //draw the pointer  
    TV.set_pixel(Rpointer[0] + 1,Rpointer[1] + 1,INVERT); //draw the pointer  
}//end of restore the old pointer

void printpointer(void)
{
    TV.set_pixel(pointer[0],pointer[1],INVERT); //draw the pointer 
    TV.set_pixel(pointer[0],pointer[1] + 1,INVERT); //draw the pointer  
    TV.set_pixel(pointer[0] + 1,pointer[1],INVERT); //draw the pointer  
    TV.set_pixel(pointer[0] + 1,pointer[1] + 1,INVERT); //draw the pointer 
    Rpointer[0] = pointer[0];
    Rpointer[1] = pointer[1];  //remember this pointer
}//end of print the cursor

void setnumber(char x, char y, char number) //try to set a selected number
{//values 0 t0 8

 for(char i =0; i < 81; i++)  //get the Y row into sudoku[]
 sudoku[i] = EEPROM.read(y*81 + i);

 if((sudoku[x*9 + number] >= 1) && (sudoku[x*9 + number] <= 9))//only select if possible
 {
   TV.tone(2093, 50);
 for(char i = 0; i < 9; i++) //show selected and set rest of the number to 0
 {
 if(i != number)
 sudoku[x*9 + i] = 0; //set rest to 0
 else
 sudoku[x*9 + i] +=10;//show that it has been selected
 }//end of select this number
 
 for(char i = 0; i < 9; i++) //set all the numbers on this row to 0
 {
 if(i != x)
 sudoku[i*9 + number] = 0; // 
 }//end of clear row of this number
 
 for(char i =0; i < 81; i++)  //get sudoku[] back to row Y
 EEPROM.write(y*81 + i,sudoku[i]);
 
 for(char j =0; j < 9; j++)  //get the X column into sudoku[]
 {
  for(char i =0; i < 9; i++)
  sudoku[j*9 + i] = EEPROM.read(x*9 + j*81 + i); //the group 9 numbers in this X  
 }//end of  9 in Y column load 
 
  for(char i = 0; i < 9; i++) // clear this column of the number
  {
  if(i != y)
  sudoku[i*9 + number] = 0;
  }//end of clear column of this number
  
 for(char j =0; j < 9; j++)  //get  sudoku[] into X column
 {
  for(char i =0; i < 9; i++)
  EEPROM.write(x*9 + j*81 + i,sudoku[j*9 + i]); //the group 9 numbers in this X  
 }//end of  9 in Y column restore
 
 for(char j =0; j < 3; j++)  //get the 3X3 box into sudoku[]
 {
  for(char i =0; i < 3; i++) 
 {
  for(char n =0; n < 9; n++)
  sudoku[j*27 + i*9 + n] = EEPROM.read((y/3)*243 + j*81 + (x/3)*27 + i*9 + n);
 }//end of i the x counter  
 }//end of j the Y counter  end of get 3X3 into sudoku[]

  for(char i = 0; i < 9; i++) //set all the numbers on this 3X3 box to 0
 {
 if(i != ((y%3)*3 + (x%3)))
 sudoku[9*i + number] = 0; // 
 }//end of clear 3X3 of this number
 
  for(char j =0; j < 3; j++)  //restore the 3X3 box
 {
  for(char i =0; i < 3; i++) 
 {
  for(char n =0; n < 9; n++)
  EEPROM.write((y/3)*243 + j*81 + (x/3)*27 + i*9 + n, sudoku[j*27 + i*9 + n]);
 }//end of i the x counter  
 }//end of j the Y counter  end of 3X3 box restore
 }//end of only select if possible
 else {
   TV.tone(131, 50);
 }
}//end of set number

void printdisplay(void)
{
 for(char k = 0; k < 9; k++)  //read all 9 rows
 {
 for(char j = 0; j < 9; j++) //read a row from the stored sudoku
 {
 char allzeros = 0; //if it has all zeros then its a blank(no possible)
 char number[9]; //tempory store for 9 numbers = 1 sudoku number
 sudoku[j] = 0;  //assume that it has not been selected
 for(char i = 0; i < 9; i++)
 {
 number[i] = EEPROM.read(k*81 +j*9 + i); //get from stored sudoku
 if(number[i] == 0)  //count the zeros
 allzeros += 1;
 if(number[i] >= 11)  //has this number been selected
 {
 sudoku[j] = number[i] + 38; //convert to char display
 break; 
 }//end of this number has been selected
 }//end of look at each 9 numbers = 1 sudoku number
 if(allzeros == 9)  //is every number zero
    sudoku[j] = 0x2b; //print a "+" to show its a blank
 if(sudoku[j] <= 9)
 sudoku[j] = 0x20; //print a blank to show its missing
 TV.print_char(numberX[j],numberY[k],sudoku[j]);
 }//end of a row of 81 characters 9 of 9 numbers 
 }//end of read all 9 rows of number

}//end of print display

void refresh (void) //refresh the screen
{
    TV.clear_screen();
    
    for (char i = 0; i < 14; i++)   //select horizontal lines 
    {
      TV.draw_line(52,ylines[i],127,ylines[i],WHITE); 
    }//end of draw horozontal outlines of sudoku
     for (char i = 0; i < 14; i++)   //select vertical lines 
    {
      TV.draw_line(xlines[i],0,xlines[i],94,WHITE); 
    }//end of draw vertical outlines of sudoku
       
    for (char i = 0; i < 10; i++)
    {
      TV.draw_line(32,i*10,40,i*10,WHITE); //select horizontal lines 
    }//end of draw outlines of select
    TV.draw_line(32,0,32,90,WHITE);  //select vertical line
    TV.draw_line(40,0,40,90,WHITE);  //select vertical line 
    for (char i = 0; i < 9; i++)
    {
      TV.print_char(35,3 + i*10,i + 0x31);
    }//end of store numbers in number select
    TV.draw_rect(33,1 + select*10,6,8,WHITE,INVERT);//show which number is selected
     
    TV.draw_line(0,0,20,0,WHITE); //horizontal line
    TV.draw_line(0,10,20,10,WHITE); //horizontal line
    TV.draw_line(0,0,0,10,WHITE); //vertical line
    TV.draw_line(20,0,20,10,WHITE); //vertical line
    TV.println(3,3,"EASY");
    TV.draw_line(0,20,20,20,WHITE); //horizontal line
    TV.draw_line(0,30,20,30,WHITE); //horizontal line
    TV.draw_line(0,20,0,30,WHITE); //vertical line
    TV.draw_line(20,20,20,30,WHITE); //vertical line
    TV.println(3,23,"MED");
    TV.draw_line(0,40,20,40,WHITE); //horizontal line
    TV.draw_line(0,50,20,50,WHITE); //horizontal line
    TV.draw_line(0,40,0,50,WHITE); //vertical line
    TV.draw_line(20,40,20,50,WHITE); //vertical line
    TV.println(3,43,"HARD");     
   
    printpointer();  //the start pointer
}//end of refresh
