https://feuniverse.us/t/fe7-my-new-portrait-system-that-supports-a-full-96x80-or-80x96-box/2333

# Features

- A full 96x80 or 80 x 96 size available.
- Adjust the position of the frame in the unit boundar freely.
- Completely compatible with the old portrait format.

# Format

96x80: ![image](https://github.com/user-attachments/assets/3c08dd5d-08b2-41d0-bf00-643d72cfd7e3) => ![image](https://github.com/user-attachments/assets/485c12d6-12e8-43ff-ba0a-c35897ac6b51)

80x96: ![image](https://github.com/user-attachments/assets/6677227a-2276-4651-a699-92953f077071) => ![image](https://github.com/user-attachments/assets/36d46a4f-bac5-4ff6-9fc8-610a1b4d5502)

the struct of the portrait info in the pointer table:

- 4 bytes → a pointer to the main portrait
- 4 bytes → a pointer to the mini portrait
- 4 bytes → a pointer to the palette
- 4 bytes → a pointer to the mouth frame
- 4 bytes → a pointer to the eye frame / classcard
- 2 bytes → the position of the mouth frame
- 2 bytes → the position of the eye frame
- 1 byte → eye control flag
- 1 byte → new / old format & V/H flag
- 2 bytes → the position of the frame in the unit boundar

# Example

- 96x80

![image](https://github.com/user-attachments/assets/d330b0e7-779d-4fb3-ae72-002e6ac676a3)

the main portrait image:

![image](https://github.com/user-attachments/assets/25b67bed-0224-48fa-a677-eb96c7d243cd)

the eye frame image:

![image](https://github.com/user-attachments/assets/9d4a0b89-7423-44ab-be4e-1fc5d535c9f1)

- 80x96

![image](https://github.com/user-attachments/assets/9d49b2c2-9c3a-452d-a091-d66b0335d8f7)

the main portrait image:

![image](https://github.com/user-attachments/assets/83168c69-6b52-4b90-b398-553eb15a23d0)

the eye frame image:

![image](https://github.com/user-attachments/assets/647c9395-21e8-4dd3-86a2-5cdfb7e695eb)

## Source Code

```C
struct Portrait{
	void *mainPortrait;	
	void *miniPortrait;	
	void *portraitPalette;	
	void *mouthFrame;	
	void *classCard;	
	s8 mouthPositionX;	
	s8 mouthPositionY;	
	s8 eyePositionX;		
	s8 eyePositionY;		
	s8 eyeControlFlag;	
	s8 portraitFormatFlag;	
	s8 boxPositionX;	
	s8 boxPositionY;	
};

const u16 newPortraitTemplateRightH[1 + 3 * 10] =
{
	10,
	0x4000, 0xC1E0, 0,
	0x4020, 0xC1E0, 8,
	0x4040, 0x81E0, 0x10,
	0x4040, 0x8000, 0x50,
	0x8030, 0x81D0, 0x14,
	0x8030, 0x8020, 0x16,
	0x8010, 0x81D0, 0x18,
	0x8010, 0x8020, 0x1A,
	0, 0x41D0, 0x5C,
	0, 0X4020, 0X5E
};


const u16 newPortraitTemplateLeftH[1 + 3 * 10] =
{
	10,
	0x4000, 0xD1E0, 0,
	0x4020, 0xD1E0, 8,
	0x4040, 0x91E0, 0x50,
	0x4040, 0x9000, 0x10,
	0x8030, 0x91D0, 0x16,
	0x8030, 0x9020, 0x14,
	0x8010, 0x91D0, 0x1A,
	0x8010, 0x9020, 0x18,
	0, 0x51D0, 0x5E,
	0, 0X5020, 0X5C
};


const u16 newPortraitTemplateLeftV[1 + 3 * 10] =
{
	7,
	getObjectAttribute1(1,-16), getObjectAttribute2(3,1,40 - 64), getObjectAttribute3(0),											
	getObjectAttribute1(2,-16), getObjectAttribute2(2,1,-40), getObjectAttribute3(8),										
	getObjectAttribute1(1,16), getObjectAttribute2(3,1,40 - 64), getObjectAttribute3(8 + 2),										
	getObjectAttribute1(2,16), getObjectAttribute2(2,1,-40), getObjectAttribute3(8 + 2 + 8),								
	getObjectAttribute1(1,16 + 32), getObjectAttribute2(3,1,40 - 64), getObjectAttribute3(8 + 2 + 8 + 2),							
	getObjectAttribute1(0,16 + 32), getObjectAttribute2(1,1,-40), getObjectAttribute3(8 + 2 + 8 + 2 + 8 + 32 * 2),			
	getObjectAttribute1(0,16 + 32 + 16), getObjectAttribute2(1,1,-40), getObjectAttribute3(8 + 2 + 8 + 2 + 8 + 32 * 2 + 2)	

};


const u16 newPortraitTemplateRightV[1 + 3 * 10] =
{
	7,
	getObjectAttribute1(1,-16), getObjectAttribute2(3,0,-40), getObjectAttribute3(0),											
	getObjectAttribute1(2,-16), getObjectAttribute2(2,0,40 - 16), getObjectAttribute3(8),										
	getObjectAttribute1(1,16), getObjectAttribute2(3,0,-40), getObjectAttribute3(8 + 2),										
	getObjectAttribute1(2,16), getObjectAttribute2(2,0,40 - 16), getObjectAttribute3(8 + 2 + 8),								
	getObjectAttribute1(1,16 + 32), getObjectAttribute2(3,0,-40), getObjectAttribute3(8 + 2 + 8 + 2),							
	getObjectAttribute1(0,16 + 32), getObjectAttribute2(1,0,40 - 16), getObjectAttribute3(8 + 2 + 8 + 2 + 8 + 32 * 2),			
	getObjectAttribute1(0,16 + 32 + 16), getObjectAttribute2(1,0,40 - 16), getObjectAttribute3(8 + 2 + 8 + 2 + 8 + 32 * 2 + 2)	
};




const u16 newPortraitInBoxTemplateH[1 + 10 * 9 + 1] =
{
	0x809, 
	0x55, 0x10, 0x11, 0x12, 0x13, 0x50, 0x51, 0x52, 0x53, 0x56,
	0x35, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x36,
	0x15, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x16,
	0x79, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x7A,
	0x59, 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x5A,
	0x39, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x3A,
	0x19, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x1A,
	0x7D, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x7E,
	0x5D, 0, 1, 2, 3, 4, 5, 6, 7, 0x5E,
	0
};


const u16 newPortraitInBoxTemplateLH[1 + 10 * 9 + 1] =
{
	0x809, 
	0x10, 0x11, 0x12, 0x13, 0x50, 0x51, 0x52, 0x53, 0x56, 0x57,
	0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x36, 0x37,
	0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x16, 0x17,
	0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x7A, 0x7B,
	8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x5A, 0x5B,
	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x3A, 0x3B,
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x1A, 0x1B,
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x7E, 0x7F,
	0, 1, 2, 3, 4, 5, 6, 7, 0x5E, 0x5F,
	0
};


const u16 newPortraitInBoxTemplateRH[1 + 10 * 9 + 1] =
{
	0x809, 
	0x54, 0x55, 0x10, 0x11, 0x12, 0x13, 0x50, 0x51, 0x52, 0x53,
	0x34, 0x35, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
	0x14, 0x15, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
	0x78, 0x79, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
	0x58, 0x59, 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
	0x38, 0x39, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
	0x18, 0x19, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
	0x7C, 0x7D, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
	0x5C, 0x5D, 0, 1, 2, 3, 4, 5, 6, 7,
	0
};


const u16 newPortraitInBoxTemplateUH[1 + 10 * 9 + 1] =
{
	0x809, 
	0x75, 0x30, 0x31, 0x32, 0x33, 0x70, 0x71, 0x72, 0x73, 0x76,
	0x55, 0x10, 0x11, 0x12, 0x13, 0x50, 0x51, 0x52, 0x53, 0x56,
	0x35, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x36,
	0x15, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x16,
	0x79, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x7A,
	0x59, 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x5A,
	0x39, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x3A,
	0x19, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x1A,
	0x7D, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x7E,
	0
};


const u16 newPortraitInBoxTemplateLUH[1 + 10 * 9 + 1] =
{
	0x809, 
	0x30, 0x31, 0x32, 0x33, 0x70, 0x71, 0x72, 0x73, 0x76, 0x77,
	0x10, 0x11, 0x12, 0x13, 0x50, 0x51, 0x52, 0x53, 0x56, 0x57,
	0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F, 0x36, 0x37,
	0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F, 0x16, 0x17,
	0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F, 0x7A, 0x7B,
	8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF, 0x5A, 0x5B,
	0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67, 0x3A, 0x3B,
	0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47, 0x1A, 0x1B,
	0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27, 0x7E, 0x7F,
	0
};


const u16 newPortraitInBoxTemplateRUH[1 + 10 * 9 + 1] =
{
	0x809, 
	0x74, 0x75, 0x30, 0x31, 0x32, 0x33, 0x70, 0x71, 0x72, 0x73,
	0x54, 0x55, 0x10, 0x11, 0x12, 0x13, 0x50, 0x51, 0x52, 0x53,
	0x34, 0x35, 0x68, 0x69, 0x6A, 0x6B, 0x6C, 0x6D, 0x6E, 0x6F,
	0x14, 0x15, 0x48, 0x49, 0x4A, 0x4B, 0x4C, 0x4D, 0x4E, 0x4F,
	0x78, 0x79, 0x28, 0x29, 0x2A, 0x2B, 0x2C, 0x2D, 0x2E, 0x2F,
	0x58, 0x59, 8, 9, 0xA, 0xB, 0xC, 0xD, 0xE, 0xF,
	0x38, 0x39, 0x60, 0x61, 0x62, 0x63, 0x64, 0x65, 0x66, 0x67,
	0x18, 0x19, 0x40, 0x41, 0x42, 0x43, 0x44, 0x45, 0x46, 0x47,
	0x7C, 0x7D, 0x20, 0x21, 0x22, 0x23, 0x24, 0x25, 0x26, 0x27,
	0
};


const u16 newPortraitInBoxTemplateV[1 + 10 * 9 + 1] =
{
	0x809, 
	getTileNo(20,3), getTileNo(21,3), getTileNo(22,3), getTileNo(23,3), getTileNo(24,3), getTileNo(25,3), getTileNo(26,3), getTileNo(27,3), getTileNo(30,3), getTileNo(31,3),
	getTileNo(20,2), getTileNo(21,2), getTileNo(22,2), getTileNo(23,2), getTileNo(24,2), getTileNo(25,2), getTileNo(26,2), getTileNo(27,2), getTileNo(30,2), getTileNo(31,2),
	getTileNo(20,1), getTileNo(21,1), getTileNo(22,1), getTileNo(23,1), getTileNo(24,1), getTileNo(25,1), getTileNo(26,1), getTileNo(27,1), getTileNo(28,3), getTileNo(29,3),
	getTileNo(20,0), getTileNo(21,0), getTileNo(22,0), getTileNo(23,0), getTileNo(24,0), getTileNo(25,0), getTileNo(26,0), getTileNo(27,0), getTileNo(28,2), getTileNo(29,2),
	getTileNo(10,3), getTileNo(11,3), getTileNo(12,3), getTileNo(13,3), getTileNo(14,3), getTileNo(15,3), getTileNo(16,3), getTileNo(17,3), getTileNo(18,3), getTileNo(19,3),
	getTileNo(10,2), getTileNo(11,2), getTileNo(12,2), getTileNo(13,2), getTileNo(14,2), getTileNo(15,2), getTileNo(16,2), getTileNo(17,2), getTileNo(18,2), getTileNo(19,2),
	getTileNo(10,1), getTileNo(11,1), getTileNo(12,1), getTileNo(13,1), getTileNo(14,1), getTileNo(15,1), getTileNo(16,1), getTileNo(17,1), getTileNo(18,1), getTileNo(19,1),
	getTileNo(10,0), getTileNo(11,0), getTileNo(12,0), getTileNo(13,0), getTileNo(14,0), getTileNo(15,0), getTileNo(16,0), getTileNo(17,0), getTileNo(18,0), getTileNo(19,0),
	getTileNo(0,3), getTileNo(1,3), getTileNo(2,3), getTileNo(3,3), getTileNo(4,3), getTileNo(5,3), getTileNo(6,3), getTileNo(7,3), getTileNo(8,3), getTileNo(9,3),
	0
};


const u16 newPortraitInBoxTemplateUV[1 + 10 * 9 + 1] =
{
	0x809, 
	getTileNo(20,2), getTileNo(21,2), getTileNo(22,2), getTileNo(23,2), getTileNo(24,2), getTileNo(25,2), getTileNo(26,2), getTileNo(27,2), getTileNo(30,2), getTileNo(31,2),
	getTileNo(20,1), getTileNo(21,1), getTileNo(22,1), getTileNo(23,1), getTileNo(24,1), getTileNo(25,1), getTileNo(26,1), getTileNo(27,1), getTileNo(28,3), getTileNo(29,3),
	getTileNo(20,0), getTileNo(21,0), getTileNo(22,0), getTileNo(23,0), getTileNo(24,0), getTileNo(25,0), getTileNo(26,0), getTileNo(27,0), getTileNo(28,2), getTileNo(29,2),
	getTileNo(10,3), getTileNo(11,3), getTileNo(12,3), getTileNo(13,3), getTileNo(14,3), getTileNo(15,3), getTileNo(16,3), getTileNo(17,3), getTileNo(18,3), getTileNo(19,3),
	getTileNo(10,2), getTileNo(11,2), getTileNo(12,2), getTileNo(13,2), getTileNo(14,2), getTileNo(15,2), getTileNo(16,2), getTileNo(17,2), getTileNo(18,2), getTileNo(19,2),
	getTileNo(10,1), getTileNo(11,1), getTileNo(12,1), getTileNo(13,1), getTileNo(14,1), getTileNo(15,1), getTileNo(16,1), getTileNo(17,1), getTileNo(18,1), getTileNo(19,1),
	getTileNo(10,0), getTileNo(11,0), getTileNo(12,0), getTileNo(13,0), getTileNo(14,0), getTileNo(15,0), getTileNo(16,0), getTileNo(17,0), getTileNo(18,0), getTileNo(19,0),
	getTileNo(0,3), getTileNo(1,3), getTileNo(2,3), getTileNo(3,3), getTileNo(4,3), getTileNo(5,3), getTileNo(6,3), getTileNo(7,3), getTileNo(8,3), getTileNo(9,3),
	getTileNo(0,2), getTileNo(1,2), getTileNo(2,2), getTileNo(3,2), getTileNo(4,2), getTileNo(5,2), getTileNo(6,2), getTileNo(7,2), getTileNo(8,2), getTileNo(9,2),
	0
};


const u16 newPortraitInBoxTemplateUUV[1 + 10 * 9 + 1] =
{
	0x809, 
	getTileNo(20,1), getTileNo(21,1), getTileNo(22,1), getTileNo(23,1), getTileNo(24,1), getTileNo(25,1), getTileNo(26,1), getTileNo(27,1), getTileNo(28,3), getTileNo(29,3),
	getTileNo(20,0), getTileNo(21,0), getTileNo(22,0), getTileNo(23,0), getTileNo(24,0), getTileNo(25,0), getTileNo(26,0), getTileNo(27,0), getTileNo(28,2), getTileNo(29,2),
	getTileNo(10,3), getTileNo(11,3), getTileNo(12,3), getTileNo(13,3), getTileNo(14,3), getTileNo(15,3), getTileNo(16,3), getTileNo(17,3), getTileNo(18,3), getTileNo(19,3),
	getTileNo(10,2), getTileNo(11,2), getTileNo(12,2), getTileNo(13,2), getTileNo(14,2), getTileNo(15,2), getTileNo(16,2), getTileNo(17,2), getTileNo(18,2), getTileNo(19,2),
	getTileNo(10,1), getTileNo(11,1), getTileNo(12,1), getTileNo(13,1), getTileNo(14,1), getTileNo(15,1), getTileNo(16,1), getTileNo(17,1), getTileNo(18,1), getTileNo(19,1),
	getTileNo(10,0), getTileNo(11,0), getTileNo(12,0), getTileNo(13,0), getTileNo(14,0), getTileNo(15,0), getTileNo(16,0), getTileNo(17,0), getTileNo(18,0), getTileNo(19,0),
	getTileNo(0,3), getTileNo(1,3), getTileNo(2,3), getTileNo(3,3), getTileNo(4,3), getTileNo(5,3), getTileNo(6,3), getTileNo(7,3), getTileNo(8,3), getTileNo(9,3),
	getTileNo(0,2), getTileNo(1,2), getTileNo(2,2), getTileNo(3,2), getTileNo(4,2), getTileNo(5,2), getTileNo(6,2), getTileNo(7,2), getTileNo(8,2), getTileNo(9,2),
	getTileNo(0,1), getTileNo(1,1), getTileNo(2,1), getTileNo(3,1), getTileNo(4,1), getTileNo(5,1), getTileNo(6,1), getTileNo(7,1), getTileNo(8,1), getTileNo(9,1),
	0
};


const u16 newPortraitInBoxTemplateUUUV[1 + 10 * 9 + 1] =
{
	0x809, 
	getTileNo(20,0), getTileNo(21,0), getTileNo(22,0), getTileNo(23,0), getTileNo(24,0), getTileNo(25,0), getTileNo(26,0), getTileNo(27,0), getTileNo(28,2), getTileNo(29,2),
	getTileNo(10,3), getTileNo(11,3), getTileNo(12,3), getTileNo(13,3), getTileNo(14,3), getTileNo(15,3), getTileNo(16,3), getTileNo(17,3), getTileNo(18,3), getTileNo(19,3),
	getTileNo(10,2), getTileNo(11,2), getTileNo(12,2), getTileNo(13,2), getTileNo(14,2), getTileNo(15,2), getTileNo(16,2), getTileNo(17,2), getTileNo(18,2), getTileNo(19,2),
	getTileNo(10,1), getTileNo(11,1), getTileNo(12,1), getTileNo(13,1), getTileNo(14,1), getTileNo(15,1), getTileNo(16,1), getTileNo(17,1), getTileNo(18,1), getTileNo(19,1),
	getTileNo(10,0), getTileNo(11,0), getTileNo(12,0), getTileNo(13,0), getTileNo(14,0), getTileNo(15,0), getTileNo(16,0), getTileNo(17,0), getTileNo(18,0), getTileNo(19,0),
	getTileNo(0,3), getTileNo(1,3), getTileNo(2,3), getTileNo(3,3), getTileNo(4,3), getTileNo(5,3), getTileNo(6,3), getTileNo(7,3), getTileNo(8,3), getTileNo(9,3),
	getTileNo(0,2), getTileNo(1,2), getTileNo(2,2), getTileNo(3,2), getTileNo(4,2), getTileNo(5,2), getTileNo(6,2), getTileNo(7,2), getTileNo(8,2), getTileNo(9,2),
	getTileNo(0,1), getTileNo(1,1), getTileNo(2,1), getTileNo(3,1), getTileNo(4,1), getTileNo(5,1), getTileNo(6,1), getTileNo(7,1), getTileNo(8,1), getTileNo(9,1),
	getTileNo(0,0), getTileNo(1,0), getTileNo(2,0), getTileNo(3,0), getTileNo(4,0), getTileNo(5,0), getTileNo(6,0), getTileNo(7,0), getTileNo(8,0), getTileNo(9,0),
	0
};




const void *newPortraitInBoxTemplateTableH[3 * 2] =
{
	newPortraitInBoxTemplateLH,
	newPortraitInBoxTemplateH,
	newPortraitInBoxTemplateRH,
	newPortraitInBoxTemplateLUH,
	newPortraitInBoxTemplateUH,
	newPortraitInBoxTemplateRUH
};


const void *newPortraitInBoxTemplateTableV[4] =
{
	newPortraitInBoxTemplateV,
	newPortraitInBoxTemplateUV,
	newPortraitInBoxTemplateUUV,
	newPortraitInBoxTemplateUUUV
};


void blinkOrWinkH(u32 *mempool, int eyeStatus)
{
	int eyeShape;	
	int winkFlag;	
	struct Portrait *portrait;	
	
	portrait = (struct Portrait *)(*(u32 *)(mempool[11] + 44));
	if(getEyeFrameTileNoDeltaH(portrait) == -1)	
		return;
	if(eyeStatus & (~0x81))
	{
		changeTiles((int)portrait->mainPortrait + 4 + 32 * getEyeFrameTileNoDeltaH(portrait),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait)) & 0x3FF),4,1);
		if(getEyeFrameTileNoDeltaH(portrait) >= 32 * 3 && getEyeFrameTileNoDeltaH(portrait) <= 32 * 3 + 4)
			changeTiles((int)portrait->mainPortrait + 4 + 32 * (getEyeFrameTileNoDeltaH(portrait) - 32 * 3 + 8),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait) - 32 * 3 + 8) & 0x3FF),4,1);
		else
			changeTiles((int)portrait->mainPortrait + 4 + 32 * (getEyeFrameTileNoDeltaH(portrait) + 32),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait) - 32 * 3 + 8) & 0x3FF),4,1);
		return;
	}
	eyeShape = eyeStatus & 1;
	winkFlag = eyeStatus & 0x80;
	if(getEyeFrameTileNoDeltaH(portrait) >= 32 * 3 && getEyeFrameTileNoDeltaH(portrait) <= 32 * 3 + 4)	
		if(winkFlag)
		{
			changeTiles((int)portrait->classCard + 32 * (4 * 2 * eyeShape + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait) + 2) & 0x3FF),2,1);
			changeTiles((int)portrait->classCard + 32 * (4 * (2 * eyeShape + 1) + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait) + 2 - 32 * 3 + 8) & 0x3FF),2,1);
		}
		else
		{
			changeTiles((int)portrait->classCard + 32 * 4 * 2 * eyeShape,0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait)) & 0x3FF),4,1);
			changeTiles((int)portrait->classCard + 32 * 4 * (2 * eyeShape + 1),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait) - 32 * 3 + 8) & 0x3FF),4,1);
		}
	else	
		if(winkFlag)
		{
			changeTiles((int)portrait->classCard + 32 * (4 * 2 * eyeShape + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait) + 2) & 0x3FF),2,1);
			changeTiles((int)portrait->classCard + 32 * (4 * (2 * eyeShape + 1) + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait) + 2 + 32) & 0x3FF),2,1);
		}
		else
			changeTiles((int)portrait->classCard + 32 * 4 * 2 * eyeShape,0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + getEyeFrameTileNoDeltaH(portrait)) & 0x3FF),4,2);
}


void blinkOrWinkV(u32 *mempool, int eyeStatus)
{
	int eyeShape;	
	int winkFlag;	
	struct Portrait *portrait;	
	
	int x;	
	int y;	
	
	portrait = (struct Portrait *)(*(u32 *)(mempool[11] + 44));
	x = portrait->eyePositionX - 1;
	y = portrait->eyePositionY + 2;
	if(x < 0 || x > 6 || y < 0 || y > 10 || (x > 4 && y > 6))	
		return;
	eyeShape = min(eyeStatus & 3,2);
	if(++eyeShape == 3)
		eyeShape = 0;
	winkFlag = eyeStatus & 0x80;
	
	if(y <= 2)	
	{
		if(winkFlag)
		{
			changeTiles((int)portrait->classCard + 32 * (4 * 2 * eyeShape + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * y + x + 2) & 0x3FF),2,1);
			changeTiles((int)portrait->classCard + 32 * (4 * (2 * eyeShape + 1) + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * y + x + 2) & 0x3FF),2,1);
		}
		else
			changeTiles((int)portrait->classCard + 32 * 4 * 2 * eyeShape,0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * y + x) & 0x3FF),4,2);
	}
	else if(y <= 3)	
	{
		if(winkFlag)
		{
			changeTiles((int)portrait->classCard + 32 * (4 * 2 * eyeShape + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * y + x + 2) & 0x3FF),2,1);
			changeTiles((int)portrait->classCard + 32 * (4 * (2 * eyeShape + 1) + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 4 + 1) + 10 + x + 2) & 0x3FF),2,1);
		}
		else
		{
			changeTiles((int)portrait->classCard + 32 * 4 * 2 * eyeShape,0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * y + x) & 0x3FF),4,1);
			changeTiles((int)portrait->classCard + 32 * 4 * 2 * eyeShape,0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 4 + 1) + 10 + x) & 0x3FF),4,1);
		}
	}
	else if(y <= 6)	
	{
		if(winkFlag)
		{
			changeTiles((int)portrait->classCard + 32 * (4 * 2 * eyeShape + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 4) + 10 + x + 2) & 0x3FF),2,1);
			changeTiles((int)portrait->classCard + 32 * (4 * (2 * eyeShape + 1) + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 4 + 1) + 10 + x + 2) & 0x3FF),2,1);
		}
		else
			changeTiles((int)portrait->classCard + 32 * 4 * 2 * eyeShape,0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 4) + 10 + x) & 0x3FF),4,2);
	}
	else if(y <= 7)	
	{
		if(winkFlag)
		{
			changeTiles((int)portrait->classCard + 32 * (4 * 2 * eyeShape + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 4) + 10 + x + 2) & 0x3FF),2,1);
			changeTiles((int)portrait->classCard + 32 * (4 * (2 * eyeShape + 1) + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 8 + 1) + 20 + x + 2) & 0x3FF),2,1);
		}
		else
		{
			changeTiles((int)portrait->classCard + 32 * 4 * 2 * eyeShape,0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 4) + 10 + x) & 0x3FF),4,1);
			changeTiles((int)portrait->classCard + 32 * 4 * 2 * eyeShape,0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 8 + 1) + 20 + x) & 0x3FF),4,1);
		}
	}
	else	
	{
		if(winkFlag)
		{
			changeTiles((int)portrait->classCard + 32 * (4 * 2 * eyeShape + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 8) + 20 + x + 2) & 0x3FF),2,1);
			changeTiles((int)portrait->classCard + 32 * (4 * (2 * eyeShape + 1) + 2),0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 8 + 1) + 20 + x + 2) & 0x3FF),2,1);
		}
		else
			changeTiles((int)portrait->classCard + 32 * 4 * 2 * eyeShape,0x6010000 + 32 * ((*(u16 *)(mempool[11] + 60) + 32 * (y - 8) + 20 + x) & 0x3FF),4,2);
	}
	
}



int getEyeFrameTileNoDeltaH(struct Portrait *portrait)
{
	if(portrait->eyePositionX < 2 || portrait->eyePositionX > 6 || portrait->eyePositionY < 0 || portrait->eyePositionY > 6)
		return -1;
	else
		if(portrait->eyePositionY < 4)
			return 32 * portrait->eyePositionY + portrait->eyePositionX - 2;
		else
			return 32 * (portrait->eyePositionY - 4) + portrait->eyePositionX - 2 + 8;
}


void callBlinkOrWink(u32 *mempool, int eyeStatus)
{
	struct Portrait *portrait;	


	portrait = (struct Portrait *)(*(u32 *)(mempool[11] + 44));
	if(portrait->portraitFormatFlag)		
	{
		if(portrait->portraitFormatFlag & 2)	
			blinkOrWinkV(mempool,eyeStatus);	
		else
			blinkOrWinkH(mempool,eyeStatus);	
	}											
	else										
		oldBlinkOrWink(mempool,eyeStatus);		
}


void callCallBlinkOrWink(u32 *mempool, int eyeStatus)
{
	callBlinkOrWink(mempool,eyeStatus);
}



void blink(s16 *mempool)
{
	int eyeStatus;

	eyeStatus = 2;
	if(mempool[26] <= 0xA)
	{
		switch(mempool[26])
		{
			case 3u:
			case 4u:
			case 5u:
				eyeStatus = 0;
				break;
			case 0u:
			case 1u:
			case 2u:
			case 6u:
			case 7u:
			case 8u:
				eyeStatus = 1;
				break;
			case 0xAu:
				sub(80045FC)((int)mempool,0);
				break;
			default:
				break;
		}
	}
	callCallBlinkOrWink((u32 *)mempool,eyeStatus);
	++mempool[26];
}


__attribute__((section(".callBlink")))
void callBlink(s16 *mempool)
{
	blink(mempool);
}


void sub_80077E8(s16 *mempool)
{
	if(mempool[26] > 5)
	{
		callCallBlinkOrWink((u32 *)mempool,0);
		if(!mempool[25])
			sub(80045FC)((int)mempool,1);
	}
	else
		blink(mempool);
}


__attribute__((section(".call_sub_80077E8")))
void call_sub_80077E8(s16 *mempool)
{
	sub_80077E8(mempool);
}


void sub_8007824(s16 *mempool)
{
	if(mempool[26] > 2)
	{
		callCallBlinkOrWink((u32 *)mempool,1);
		if(!mempool[25])
			sub(80045FC)((int)mempool,1);
	}
	else
		blink(mempool);
}


__attribute__((section(".call_sub_8007824")))
void call_sub_8007824(s16 *mempool)
{
	sub_8007824(mempool);
}



void wink(s16 *mempool)
{
	int eyeStatus;

	eyeStatus = 2;
	if(mempool[26] <= 0xA)
	{
		switch(mempool[26])
		{
			case 3u:
			case 4u:
			case 5u:
				eyeStatus = 0;
				break;
			case 0u:
			case 1u:
			case 2u:
			case 6u:
			case 7u:
			case 8u:
				eyeStatus = 1;
				break;
			case 0xAu:
				sub(80045FC)((int)mempool,0);
				break;
			default:
				break;
		}
	}
	callCallBlinkOrWink((u32 *)mempool,eyeStatus + 0x80);
	++mempool[26];
}


__attribute__((section(".callWink")))
void callWink(s16 *mempool)
{
	wink(mempool);
}



void chooseMainPortraitSpriteTemplate(u32 *mempool)
{
	u32 flag1;	
	void *templateSelected;	
	u32 flag2;
	s16 delta;
	struct Portrait *portrait;	

	portrait = (struct Portrait *)mempool[11];
	flag1 = mempool[12] & 0x807;
	if ( flag1 == 3 )
	{
		if(portrait->portraitFormatFlag & 2)
			templateSelected = (void *)&newPortraitTemplateLeftV;
		else
			if(portrait->portraitFormatFlag)
				templateSelected = (void *)&newPortraitTemplateLeftH;
			else
				templateSelected = oldPortraitTemplateLeft;
LABEL_18:
		mempool[14] = (u32)templateSelected;
		goto LABEL_19;
	}
	if ( flag1 <= 3 )
	{
		if ( flag1 == 1 )
		{
			templateSelected = 0x8BFF828 + 26;
		}
		else if ( flag1 > 1 )
		{
			if(portrait->portraitFormatFlag & 2)
				templateSelected = (void *)&newPortraitTemplateRightV;
			else
				if(portrait->portraitFormatFlag)
					templateSelected = (void *)&newPortraitTemplateRightH;
				else
					templateSelected = oldPortraitTemplateRight;

		}
		else
		{
			templateSelected = 0x8BFF828;
		}
		goto LABEL_18;
	}
	if ( flag1 == 5 )
	{
		templateSelected = 0x8BFF8A8 + 50;
		goto LABEL_18;
	}
	if ( flag1 < 5 )
	{
		templateSelected = 0x8BFF8A8;
		goto LABEL_18;
	}
	if ( flag1 == 0x800 )
	{
		templateSelected = 0x8BFF90C;
		goto LABEL_18;
	}
	if ( flag1 == 0x801 )
	{
		templateSelected = 0x8BFF90C + 50;
		goto LABEL_18;
	}
LABEL_19:
	flag2 = mempool[12] & 0x3C0;
	if ( flag2 == 0x80 )
	{
		delta = 0x400;
	}
	else if ( flag2 > 0x80 )
	{
		if ( flag2 != 512 )
			goto LABEL_28;
		delta = 0xC00;
	}
	else
	{
		if ( flag2 != 0x40 )
		{
LABEL_28:
			delta = 0x800;
			goto LABEL_29;
		}
		delta = 0;
	}
LABEL_29:
	*((s16 *)mempool + 30) = (*(s32 *)(8 * *((s8 *)mempool + 64) + 0x202A580) >> 5)
															 + ((*(s16 *)(8 * *((s8 *)mempool + 64) + 0x202A584) & 0xF) << 12)
															 + delta;
}


__attribute__((section(".callChooseMainPortraitSpriteTemplate")))
void callChooseMainPortraitSpriteTemplate(s16 *mempool)
{
	chooseMainPortraitSpriteTemplate((u32 *)mempool);
}


void drawPortraitInBox(u16 *TSABufferInWRAM, int portraitID, int presentBGTileIndex, int presentBGPaletteIndex)
{
	struct Portrait *portrait;	
	u16 *i;
	signed int j;

	if(!portraitID)
		return;
	portrait = GetPortrait(portraitID);
	OutputToBGPaletteBuffer(portrait->portraitPalette, 32 * presentBGPaletteIndex, 32);
	if(portrait->mainPortrait)	
	{
		AutoCopyOrDecompressImageToVRAM(portrait->mainPortrait, 32 * presentBGTileIndex + 0x6000000);
		OutputToBGPaletteBuffer(portrait->portraitPalette, 32 * presentBGPaletteIndex, 32);
		if(portrait->portraitFormatFlag)	
		{
			if(portrait->portraitFormatFlag & 2)
				writePortraitTSAInBoxV(TSABufferInWRAM, ((presentBGPaletteIndex & 0xF)<< 12) + (presentBGTileIndex & 0x3FF), portrait);
			else
				writePortraitTSAInBoxH(TSABufferInWRAM, ((presentBGPaletteIndex & 0xF)<< 12) + (presentBGTileIndex & 0x3FF), portrait);
		}
		else	
		{
			if(PortraitHeightFix(portraitID)<<24)
				WriteHighPortraitTSAInBox(TSABufferInWRAM, ((presentBGPaletteIndex & 0xF)<< 12) + (presentBGTileIndex & 0x3FF), portrait);
			else
				WriteLowPortraitTSAInBox(TSABufferInWRAM, ((presentBGPaletteIndex & 0xF)<< 12) + (presentBGTileIndex & 0x3FF), portrait);
			
			i = TSABufferInWRAM;
			j = 5;
			do
			{
				*i = 0;
				i[9] = 0;
				i += 32;
				--j;
			}
			while(j >= 0);
		}
	}
	else	
	{
		AutoCopyOrDecompressImageToVRAM(portrait->classCard, 32 * presentBGTileIndex + 0x6000000);
		writePlainTSA(TSABufferInWRAM, (presentBGPaletteIndex << 12) + (presentBGTileIndex & 0x3FF), 10, 9);
	}
}


void writePortraitTSAInBoxH(u16 *TSABufferInWRAM, u16 tileIndexAndPaletteIndex, struct Portrait *portrait)
{
	int x;	
	int y;	
	void *templateSelected;	
	u16 *mouthTSA;	

	x = portrait->mouthPositionX - 1 + portrait->boxPositionX;
	y = portrait->mouthPositionY + portrait->boxPositionY;
	
	if(portrait->boxPositionX > -2 && portrait->boxPositionX < 2 && portrait->boxPositionY > -2 && portrait->boxPositionY < 1)
		templateSelected = newPortraitInBoxTemplateTableH[-3 * portrait->boxPositionY + portrait->boxPositionX + 1];
	else
		templateSelected = newPortraitInBoxTemplateH;
		
	
	sub(80C0C28)(TSABufferInWRAM, templateSelected, tileIndexAndPaletteIndex);
	
	
	if(!(portrait->boxPositionX > -2 && portrait->boxPositionX < 2 && portrait->boxPositionY > -2 && portrait->boxPositionY < 1))
		{
			x = portrait->mouthPositionX - 1;
			y = portrait->mouthPositionY;
		}
	mouthTSA = &TSABufferInWRAM[32 * y + x];
	mouthTSA[0] = tileIndexAndPaletteIndex + 28;
	mouthTSA[1] = tileIndexAndPaletteIndex + 29;
	mouthTSA[2] = tileIndexAndPaletteIndex + 30;
	mouthTSA[3] = tileIndexAndPaletteIndex + 31;
	mouthTSA[32] = tileIndexAndPaletteIndex + 60;
	mouthTSA[33] = tileIndexAndPaletteIndex + 61;
	mouthTSA[34] = tileIndexAndPaletteIndex + 62;
	mouthTSA[35] = tileIndexAndPaletteIndex + 63;
}


void writePortraitTSAInBoxV(u16 *TSABufferInWRAM, u16 tileIndexAndPaletteIndex, struct Portrait *portrait)
{
	int y;	
	void *templateSelected;	
	u16 *mouthTSA;	

	y = portrait->mouthPositionY - portrait->boxPositionY - 1;
	
	if(portrait->boxPositionY > -4 && portrait->boxPositionY < 1)
		templateSelected = newPortraitInBoxTemplateTableV[- portrait->boxPositionY];
	else
		templateSelected = newPortraitInBoxTemplateV;	
		
	
	sub(80C0C28)(TSABufferInWRAM, templateSelected, tileIndexAndPaletteIndex);
	
	
	if(portrait->boxPositionY < -3 || portrait->boxPositionY > 0)
		y = portrait->mouthPositionY;
	
	mouthTSA = &TSABufferInWRAM[32 * y];
	mouthTSA[0] = tileIndexAndPaletteIndex + 28;
	mouthTSA[1] = tileIndexAndPaletteIndex + 29;
	mouthTSA[2] = tileIndexAndPaletteIndex + 30;
	mouthTSA[3] = tileIndexAndPaletteIndex + 31;
	mouthTSA[32] = tileIndexAndPaletteIndex + 60;
	mouthTSA[33] = tileIndexAndPaletteIndex + 61;
	mouthTSA[34] = tileIndexAndPaletteIndex + 62;
	mouthTSA[35] = tileIndexAndPaletteIndex + 63;
}


__attribute__((section(".callDrawPortraitInBox")))
void callDrawPortraitInBox(u16 *TSABufferInWRAM, int portraitID, int presentBGTileIndex, int presentBGPaletteIndex)
{
	drawPortraitInBox(TSABufferInWRAM, portraitID, presentBGTileIndex, presentBGPaletteIndex);
}
```
