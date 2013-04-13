#define ELEMENT_COUNT 24
#define ELEMENT_SIZE 4

//room element index
PROGMEM prog_uchar room_element_index_data[] = {
0, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21, 23, 24, 26, 27, 
29, 31, 32, 34, 35, 37, 38, 39};

//room element data
PROGMEM prog_uchar room_element_data[] = {
50, 80, 23, 255,
0, 80, 15, 0, 51, 96, 31, 255,
50, 32, 39, 0, 0, 120, 15, 255,
50, 16, 47, 0, 0, 104, 15, 255,
50, 56, 31, 0, 0, 120, 31, 255,
50, 32, 55, 0, 0, 120, 47, 255,
51, 16, 55, 0, 0, 112, 31, 255,
0, 48, 31, 0, 50, 80, 23, 255,
0, 56, 39, 0, 50, 80, 55, 255,
51, 16, 55, 0, 0, 64, 39, 255,
50, 16, 7, 0, 0, 112, 15, 255,
52, 40, 55, 0, 0, 112, 31, 255,
50, 64, 31, 255,
52, 0, 55, 0, 0, 104, 7, 255,
51, 8, 55, 255,
50, 0, 39, 0, 0, 32, 63, 255,
0, 32, 47, 0, 50, 80, 55, 255,
0, 72, 47, 255,
51, 24, 47, 0, 0, 96, 47, 255,
50, 64, 47, 255,
0, 32, 31, 0, 52, 72, 31, 255,
0, 40, 31, 255,
51, 48, 39, 255,
50, 24, 63, 0, 0, 80, 39, 255,
};
