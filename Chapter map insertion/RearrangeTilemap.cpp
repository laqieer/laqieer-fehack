// RearrangeTilemap.cpp : 定义控制台应用程序的入口点。
// 重组8x8(GBA的Tile)的map到16x16(地图的Tile)的map
// Made by laqieer/MisakaMikoto@FEU
// 2016/07/31

#include "stdafx.h"
#include "fstream"
#include "iostream"
using namespace std;

typedef unsigned short u16;
struct tile
{
	u16 lefttop;
	u16 righttop;
	u16 leftbottom;
	u16 rightbottom;
};

int main()
{
	u16 raw[64][64];
	tile tile[32][32];
	for (int i = 0; i < 64; i++)
		for (int j = 0; j < 64; j++)
			raw[i][j] = 0;
	for (int i = 0; i < 32; i++)
		for (int j = 0; j < 32; j++)
			tile[i][j] = {0,0,0,0};
	ifstream infile("tileset.map.bin", ios::binary);
	if (!infile)
	{
		cerr << "Cannot open tileset.map.bin!" << endl;
		abort();//退出程序
	}
	infile.read((char*)&raw[0][0], sizeof(raw));
	infile.close();
	for (int i = 0; i < 32; i++)
		for (int j = 0; j < 32; j++)
		{
			tile[i][j].lefttop = raw[2 * i][2 * j];
			tile[i][j].righttop = raw[2 * i][2 * j + 1];
			tile[i][j].leftbottom = raw[2 * i + 1][2 * j];
			tile[i][j].rightbottom = raw[2 * i + 1][2 * j + 1];
		}
	ofstream outfile("tile.conf.bin", ios::binary);
	if (!outfile)
	{
		cerr << "Cannot create tile.conf.bin!" << endl;
		abort();//退出程序
	}
	outfile.write((char*)&tile[0][0], sizeof(tile));
	outfile.close();
	return 0;
}

