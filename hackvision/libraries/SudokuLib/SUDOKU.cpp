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

In the program we hold a sudoku step in:   char sudokuarray[729];  //sudoku array

If we print out the start sudokuarray we will see:


123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789  
 
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789  
 
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789


The numbering for this array is as follows:

X...0.........1.........2..........3........4.........5........6..........7.........8....   Y
                                                                                            .
0                                                                                       80  .
.                                                                                       .   .
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789   0  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789   1  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789   2  
                                                                                            .
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789   3    
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789   4  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789   5  
                                                                                            . 
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789   6  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789   7  
123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789   8
.                                                                                        .  .
648                                                                                      728



This program works by selecting a random X(0 to 8) a random Y(0 to 8)
and a random number(1 to 9).

The very first number will fit into this X and Y position.
To show that it has been selected this number has 10 added to it so it will be 11 to 19.
Each other number in that position will be set to zero because it can no longer be selected.

So if the selected number is 5 we will see:  0000150000 instead of 123456789.

Next we need to set each number 5 in the selected X row to 0 to show it can no longer be selected.
We need to repeat for the selected Y column and the selected 3X3 box.

With subsequent numbers we have to check that it has not been selected(11 to 19) or that
it cannot be selected(0).

As we get further along in the process we will find that a number will standalone.
That is it will be the only one which can be selected. This could be 00005000 showing that
only the 5 can be selected.
The program will select any number which stands alone.

On almost every try with random numbers we will get to the stage when one number has no
selections possible. It will be 000000000.
We call this a blank and we have reached a deadend. This sudoku cannot be solved.

We start again from the start sudokuarray.
Eventually we will get to 81 steps, a complete sudoku without blanks.
This will be a completely random sudoku solution.

We also have a array:   char workingarray[729];  //working array
This is used to record a particular step in the solution.
An easy sudoku will have about 45 selections already made.

We can set the program to record that step in the workingarray.
This is used as the start sudoku.
*/

//This program has all the subroutines placed online .
//all the subroutines are from the PrintSudoku  example program .
//after the generation of the solved sudoku the start stored in
//workingarray will be stored in first 729 bytes in EEPROM


#if defined(ARDUINO) && ARDUINO >= 100
  #include "Arduino.h"
#else
  #include "WProgram.h"
#endif
#include "SUDOKU.h"

void SUDOKUclass::generate(char start)
{
 char sudokuarray[729];  //sudoku array
 char workingarray[729];  //working array
 char arraynumber = 0;
 
 randomSeed(analogRead(0)); 
 while(arraynumber < 81) //keep trying until get full 81 steps
 {
 //try to get a sudoku solution
 //start with a new sudoku
 for(int i = 0; i < 729; i++)
 {
 sudokuarray[i] = 1 + (i % 9); //fill the array with 1 to 9
 }//end of store sudoku digit 123456789
//end of start with a new sudoku
 arraynumber = 0;
 boolean noblanks = true;

 while((arraynumber < 80) && (noblanks))// work until get a blank or full sudoku
 { 
 char x = random(9);
 char y = random(9);
 char number = random(9);
 //setnumber routine

 boolean selected = false;  //check to see if number already selected
 boolean nopossible = false;  //check to see if no possibilities to select exist
 boolean crossedout = false;  //check to see if the number has been crossed out
 
  int select = y*81 + x*9 ; //the selected group of 9 numbers 
  if(sudokuarray[select + number] == 0)//has the selected number been crossed out
  crossedout = true;
 
  char nzeros = 0;
  for(char i = 0; i < 9; i++)//check number position
 {
  if(sudokuarray[select + i] == 0)
  nzeros +=1; //we have a deleted number
  if(sudokuarray[select + i] >= 11) //has the number already been selected
  selected = true;
 }//end of check number position
  if(nzeros == 9)
  nopossible = true; //there are no numbers which can be selected
  
  if(( ! selected) && ( ! nopossible) && (! crossedout)) 
 {//select if a its not selected , possible and its not crossed out
  sudokuarray[select + number] += 10; //this number is now selected
  arraynumber += 1; //we have selected one number
  
  if(arraynumber == start) //at "n steps save the partial solved sudoku
  {
  for(int i = 0; i < 729; i++)
  workingarray[i] = sudokuarray[i];  //copy to temp store  
  }//end of we have reached "n" steps
   
   for(char i = 0; i < 9; i++) //set all to zero except selected number in box
 {
   if(i != number)
  sudokuarray[select + i] = 0; //set rest to zero
 }//end of set rest to zero
 
  for( char j = 0; j < 3; j++)  //the block of 3X3 cannot have this number
 {                              //j is Y has blocks of 243 numbers
   for(char i = 0; i < 3; i++)  //i is X has blocks of 27 numbers
   {
   if((j*81 + (y/3)*243) + (i*9 + (x/3)*27) != select) 
   sudokuarray[(j*81 + (y/3)*243) + (i*9 + (x/3)*27) + number] = 0;   
   }//end of i = x
 }//end of j = y  
 
 select = y*81 ;
 for(char i = 0; i < 9; i++) //horizontal line cannot have this number
 {
  if(i != x)
  sudokuarray[select + i*9 + number] = 0; //set rest to zero  
 }//end of set horizontal line to zero
 
 select = x*9 ;
 for(char i = 0; i < 9; i++) //vertical line cannot have this number
 {
  if(i != y)
  sudokuarray[select + i*81 + number] = 0; //set rest to zero  
 }//end of set vertical line to zero 
 }//end of select this number
//end setnumber routine
//checkselection routine
boolean standalone = true;
while(standalone)  //find if one can be selected
{
char number = 0;  //holds the selected number
standalone = false;  //flag for standalone number
for(char j = 0; j < 9; j++) //go down the 9 Y rows
{
for(char i = 0; i < 9; i++)  //go across the 9 X values
{
char crossedout = 0;  //find how many zero's in this box
for(char n = 0; n < 9; n++) //go through the 9 possible numbers
{
 if( sudokuarray[j*81 + i*9 + n] == 0) //has this has been crossed out
 crossedout += 1; //this one crossed out
 else
 number = sudokuarray[j*81 + i*9 + n]; //record a non zero number
}//end of check 9 numbers
if((crossedout == 8) && (number <= 9 )) //have we found a stanalone number
{
//setnumber routine
char x = i;
char y = j;
number = number - 1;  //set the x,y and number for setnumber
 boolean selected = false;  //check to see if number already selected
 boolean nopossible = false;  //check to see if no possibilities to select exist
 boolean crossedout = false;  //check to see if the number has been crossed out
 
  int select = y*81 + x*9 ; //the selected group of 9 numbers 
  if(sudokuarray[select + number] == 0)//has the selected number been crossed out
  crossedout = true;
 
  char nzeros = 0;
  for(char i = 0; i < 9; i++)//check number position
 {
  if(sudokuarray[select + i] == 0)
  nzeros +=1; //we have a deleted number
  if(sudokuarray[select + i] >= 11) //has the number already been selected
  selected = true;
 }//end of check number position
  if(nzeros == 9)
  nopossible = true; //there are no numbers which can be selected
  
  if(( ! selected) && ( ! nopossible) && (! crossedout)) 
 {//select if a its not selected , possible and its not crossed out
  sudokuarray[select + number] += 10; //this number is now selected
  arraynumber += 1; //we have selected one number
  
  if(arraynumber == start) //at "n steps save the partial solved sudoku
  {
  for(int i = 0; i < 729; i++)
  workingarray[i] = sudokuarray[i];  //copy to temp store  
  }//end of we have reached "n" steps
   
   for(char i = 0; i < 9; i++) //set all to zero except selected number in box
 {
   if(i != number)
  sudokuarray[select + i] = 0; //set rest to zero
 }//end of set rest to zero
 
  for( char j = 0; j < 3; j++)  //the block of 3X3 cannot have this number
 {                              //j is Y has blocks of 243 numbers
   for(char i = 0; i < 3; i++)  //i is X has blocks of 27 numbers
   {
   if((j*81 + (y/3)*243) + (i*9 + (x/3)*27) != select) 
   sudokuarray[(j*81 + (y/3)*243) + (i*9 + (x/3)*27) + number] = 0;   
   }//end of i = x
 }//end of j = y  
 
 select = y*81 ;
 for(char i = 0; i < 9; i++) //horizontal line cannot have this number
 {
  if(i != x)
  sudokuarray[select + i*9 + number] = 0; //set rest to zero  
 }//end of set horizontal line to zero
 
 select = x*9 ;
 for(char i = 0; i < 9; i++) //vertical line cannot have this number
 {
  if(i != y)
  sudokuarray[select + i*81 + number] = 0; //set rest to zero  
 }//end of set vertical line to zero 
 }//end of select this number
//end setnumber routine
standalone = true;
}//end of we have found a standalone number
}//end of 9 X values
}//end of 9 Y rows
}//end of find a standalone
//repeat until no more can be found
//end of check selection routine 
for(char j = 0; j < 9; j++) //go down the 9 Y rows
{
for(char i = 0; i < 9; i++)  //go across the 9 X values
{
char crossedout = 0;  //find how many zero's in this box
for(char n = 0; n < 9; n++) //go through the 9 possible numbers
{
 if( sudokuarray[j*81 + i*9 + n] == 0) //has this has been crossed out
 crossedout += 1; //this one crossed out
}//end of check 9 numbers
if(crossedout == 9) //do we have a number with no selection possible
noblanks = false; //we have come to the end of this run
}//end of 9 X values
}//end of 9 Y rows
 }//end of run until all done or false step
 //end of try to get a sudoku solution
 }//end of try untill have full sudokusolution
 for(unsigned int i = 0; i < 729; i++)  //we can now save the start sudoku
 { 
 EEPROM.write(i, workingarray[i]);
 }//end of save the start sudoku 
}//end of write stream


SUDOKUclass SUDOKU;
