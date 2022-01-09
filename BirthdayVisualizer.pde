/* 
This program is supposed to create a visual that shows how often certain birthdays are.
More popular birthdays are darker, while less popular birthdays are colored ligher.
When you hover your mouse over a certain square, it will give a number. 1 is most popular birthday, 
and 366 is the least popular birthday.

Rene Conrath
version from 5/21/2018 
*/

int[] month = new int[366];
int[] day = new int[366];
int[] rank = new int[366];
String[] temp;
String[] temp2;
String[] temp3;
int[] dayTotal;

void setup(){  
  size(2000, 2000);
  temp = loadStrings("month.csv"); //loads the strings. Creates array from the file data
  temp2 = loadStrings("day.csv");
  temp3 = loadStrings("rank.csv");
  
  month = int(split(temp[0], ',')); //convert 1st line of file, temp[0] into integer array
  day = int(split(temp2[0], ','));
  rank = int(split(temp3[0], ','));
  
}

void draw(){
  background(200);
  display_labels(); //calls the function that draws all the labels
  
  for(int i = 0; i < 366; i++){
    stroke(0);
    fill(252- (((366 - rank[i]) * 160) /366), 247 - (((366 - rank[i]) * 160) /366), 197 - (((366 - rank[i]) * 160) /366)); //colors the squares based on popularity
    rect(20 + month[i] * 100, 20 + day[i] * 35, 100, 35); //draws the grid of rectangles
  }
  display_values(); //calls the function that displays the number of the rectangle when you hover over it with your mouse
}

void display_values(){
  int m_index;
  int d_index;
  int r_index;
  
  int[] dayTotal = {0, 31, 60, 91, 121, 152, 182, 213, 244, 274, 305, 335, 366}; //the number of days at the beginning of each month
   
  
  m_index = ((((120 + mouseX) - 40) / 100) - 1); //this holds what month the mouse is on
  d_index = (((mouseY - 55) / 35) + 1); //this holds what day the mouse is on
  
  if(m_index > 0 && d_index > 0 && m_index <= 12 && d_index <=31){ //if the mouse is inside rectangles
    r_index = dayTotal[m_index-1] + d_index; //this holds what rectangle the mouse is one
        
    textSize(26);
    if(rank[r_index-1] > 103){ //is the rank number is high, which means the color of the rectangle is light
      fill(0); //fill black
    }else{
      fill(255); //fill white if the rank number is low, which means the color of the rectangle is dark
    }
    text(rank[r_index-1], mouseX, mouseY); //puts the text where mouseX and mouseY are located
  }
}

void display_labels(){ //this function draws all the labels
  for(int i=0; i<510; i++) { 
    stroke(252-(i * 0.5), 247-(i * 0.5), 197-(i * 0.5)); //this line will slowely get darker
    line( 500+i, 1300, 500+i, 1300+100 ); //draws a bunch of lines, each slightly darker than the last
  }
  
  textSize(26);
  fill(0);
  text("Jan       Feb       Mar       Apr      May      Jun       Jul       Aug       Sep       Oct       Nov       Dec", 150, 50); //month label on top of grid
    
  for( int i = 0; i < 31; i++){ 
    text(i + 1, 80, 82 + i * 35); //numbers along the side of the grid, for the days
  }
  
  text("Less Common                                                                   More Common", 300, 1360); //label for the gradient key
}