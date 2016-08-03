//Commands
#define LOAD	111111
#define	STORE	100000
#define ADD	000000
#define ADDC	000001
#define SUB	000010
#define	MUL	000011
#define	SHL	000100
#define	SHR	000101
#define	ROTL	000110
#define	ROTR	000111
#define	AND	001000
#define	OR	001001
#define	NOT	001010
#define	NOR	001011
#define	NAND	001100
#define	XOR	001101
#define XNOR	001110
#define	LS	001111
#define	LSE	010000
#define	GT	010001
#define	GTE	010010
#define	EQ	010011
#define SADD	010100
#define	SSUB	010101
#define SMUL	010110

#include<iostream>
#include<vector>
#include<fstream>
#include<cstring>
#include<bitset>
#include<cstdio>

using namespace std;

class Assembler{
	private :
		ifstream input;
		ofstream output;
		vector<char> instruction ;
		char *input_file,*output_file;
	public :
		Assembler(char *ip,char *op){
			input_file = ip;
			output_file = op;
			
			//if(ip==NULL)
			//	input_file = "input.dat";
			//if(op==NULL)
			//	output_file = "assemblycode.dat";
		}
		void read();
		void convert();	
		void setdatamemaddress(int);
		void setopcode(char []);
		void setsrc1(int);
		void setsrc2(int);
		void setdest(int);
		void write();
};

void Assembler :: write(){
	
}

void Assembler ::setsrc1(int a){
	bitset<5>addr(a);
	for(int j=15,i=0;j>=11;j--,i++){
		if(addr[i]==0)
			instruction[j]='0';
		else
			instruction[j]='1';
	}
}

void Assembler ::setsrc2(int a){
	bitset<5>addr(a);
	for(int j=20,i=0;j>=16;j--,i++){
		if(addr[i]==0)
			instruction[j]='0';
		else
			instruction[j]='1';
	}
}

void Assembler ::setdest(int a){
	bitset<5>addr(a);
	for(int j=10,i=0;j>=6;j--,i++){
		if(addr[i]==0)
			instruction[j]='0';
		else
			instruction[j]='1';
	}
}

void Assembler :: setopcode(char a[]){
		if(!strcmp(a,"LOAD")){
		instruction[0]='1';instruction[1]='1';instruction[2]='1';instruction[3]='1';instruction[4]='1';instruction[5]='1';
	}
	if(!strcmp(a,"STORE")){
		instruction[0]='1';instruction[1]='0';instruction[2]='0';instruction[3]='0';instruction[4]='0';instruction[5]='0';
	}
	if(!strcmp(a,"ADD")){
		instruction[0]='0';instruction[1]='0';instruction[2]='0';instruction[3]='0';instruction[4]='0';instruction[5]='0';
	}
	if(!strcmp(a,"ADDC")){
		instruction[0]='0';instruction[1]='0';instruction[2]='0';instruction[3]='0';instruction[4]='0';instruction[5]='1';
	}
	if(!strcmp(a,"SUB")){
		instruction[0]='0';instruction[1]='0';instruction[2]='0';instruction[3]='0';instruction[4]='1';instruction[5]='0';
	}
	if(!strcmp(a,"MUL")){
		instruction[0]='0';instruction[1]='0';instruction[2]='0';instruction[3]='0';instruction[4]='1';instruction[5]='1';
	}
	if(!strcmp(a,"SHL")){
		instruction[0]='0';instruction[1]='0';instruction[2]='0';instruction[3]='1';instruction[4]='0';instruction[5]='0';
	}
	if(!strcmp(a,"SHR")){
		instruction[0]='0';instruction[1]='0';instruction[2]='0';instruction[3]='1';instruction[4]='0';instruction[5]='1';
	}
	if(!strcmp(a,"ROTL")){
		instruction[0]='0';instruction[1]='0';instruction[2]='0';instruction[3]='1';instruction[4]='1';instruction[5]='0';
	}
	if(!strcmp(a,"ROTR")){
		instruction[0]='0';instruction[1]='0';instruction[2]='0';instruction[3]='1';instruction[4]='1';instruction[5]='1';
	}
	if(!strcmp(a,"AND")){
		instruction[0]='0';instruction[1]='0';instruction[2]='1';instruction[3]='0';instruction[4]='0';instruction[5]='0';
	}
	if(!strcmp(a,"OR")){
		instruction[0]='0';instruction[1]='0';instruction[2]='1';instruction[3]='0';instruction[4]='0';instruction[5]='1';
	}
	if(!strcmp(a,"NOT")){
		instruction[0]='0';instruction[1]='0';instruction[2]='1';instruction[3]='0';instruction[4]='1';instruction[5]='0';
	}
	if(!strcmp(a,"NOR")){
		instruction[0]='0';instruction[1]='0';instruction[2]='1';instruction[3]='0';instruction[4]='1';instruction[5]='1';
	}
	if(!strcmp(a,"NAND")){
		instruction[0]='0';instruction[1]='0';instruction[2]='1';instruction[3]='1';instruction[4]='0';instruction[5]='0';
	}
	if(!strcmp(a,"XOR")){
		instruction[0]='0';instruction[1]='0';instruction[2]='1';instruction[3]='1';instruction[4]='0';instruction[5]='1';
	}
	if(!strcmp(a,"XNOR")){
		instruction[0]='0';instruction[1]='0';instruction[2]='1';instruction[3]='1';instruction[4]='1';instruction[5]='0';
	}
	if(!strcmp(a,"LS")){
		instruction[0]='0';instruction[1]='0';instruction[2]='1';instruction[3]='1';instruction[4]='1';instruction[5]='1';
	}
	if(!strcmp(a,"LSE")){
		instruction[0]='0';instruction[1]='1';instruction[2]='0';instruction[3]='0';instruction[4]='0';instruction[5]='0';
	}
	if(!strcmp(a,"GT")){
		instruction[0]='0';instruction[1]='1';instruction[2]='0';instruction[3]='0';instruction[4]='0';instruction[5]='1';
	}
	if(!strcmp(a,"GTE")){
		instruction[0]='0';instruction[1]='1';instruction[2]='0';instruction[3]='0';instruction[4]='1';instruction[5]='0';
	}
	if(!strcmp(a,"EQ")){
		instruction[0]='0';instruction[1]='1';instruction[2]='0';instruction[3]='0';instruction[4]='1';instruction[5]='1';
	}
	if(!strcmp(a,"SADD")){
		instruction[0]='0';instruction[1]='1';instruction[2]='0';instruction[3]='1';instruction[4]='0';instruction[5]='0';
	}
	if(!strcmp(a,"SSUB")){
		instruction[0]='0';instruction[1]='1';instruction[2]='0';instruction[3]='1';instruction[4]='0';instruction[5]='1';
	}
	if(!strcmp(a,"SMUL")){
		instruction[0]='0';instruction[1]='1';instruction[2]='0';instruction[3]='1';instruction[4]='1';instruction[5]='0';
	}
}

void Assembler :: setdatamemaddress(int a){
	bitset<16> addr(a);
	for(int j=29,i=0;j>=14;j--,i++){
		if(addr[i]==0)
			instruction[j]='0';
		else
			instruction[j]='1';	
	}
}

void Assembler :: read(){
	input.open(input_file,ios::in );
	output.open(output_file,ios::out);
	//Dummy Instruction
}

void Assembler :: convert(){
	string line;
	char command[6];
	//set carry
	
	if(input.is_open()){
		while (getline(input,line)){
			instruction.clear();
			instruction.resize(32,'0');
			instruction[21]='1';
			cout << line << '\n';
			int i;
			for(i=0;line[i]!=' ';i++)
				command[i]=line[i];
			command[i]='\0';
			setopcode(command);
			if(!strcmp(command,"LOAD")||!strcmp(command,"STORE")){
				char address[5],dest[5];
				int hexaddress,j,dest_i;
				i=i+2;
				for(j=0;line[i]!=' ';i++,j++)
					dest[j]=line[i];
					i=i+1;
				dest[j]='\0';
				for(j=0;line[i]!='H';i++,j++)
					address[j]=line[i];
				address[j]='\0';
				sscanf(dest,"%d",&dest_i);
				sscanf(address,"%x",&hexaddress);
				setdatamemaddress(hexaddress);
				setdest(dest_i);
			}
			else{
				char src1[5],src2[5],dest[5];
				int j;
				i=i+2;
				for(j=0;line[i]!=' ';i++,j++)
					dest[j]=line[i];
				dest[j]='\0';
				i=i+2;
				for(j=0;line[i]!=' ';i++,j++)
					src1[j]=line[i];
				src1[j]='\0';
				i=i+2;
				for(j=0;line[i]!='\0';i++,j++)
					src2[j]=line[i];
				src2[j]='\0';
				int src1_i,src2_i,dest_i;
				sscanf(src1,"%d",&src1_i);
				sscanf(src2,"%d",&src2_i);
				sscanf(dest,"%d",&dest_i);
				setsrc1(src1_i);
				setsrc2(src2_i);
				setdest(dest_i);
				
			}
			
			for(int i=0;i<=31;i++){
					cout<<instruction[i];
					output<<instruction[i];
			}
				cout<<endl;	
				output<<endl;
		}
		input.close();
	}
	output.close();
}

int main(int argc,char *argv[]){
	Assembler assembler(argv[1],argv[2]);
	assembler.read();
	assembler.convert();
	return 0;
}
