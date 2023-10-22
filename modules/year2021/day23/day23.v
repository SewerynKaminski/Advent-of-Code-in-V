module day23

import os
import term
import math

//---------------------------------------------------------------------------//
const path = 'modules/year2021/day23/input'
/*const input =
'#############\n'+
'#...........#\n'+
'###B#C#B#D###\n'+
'  #A#D#C#A#  \n'+
'  #########  \n'
*/
//---------------------------------------------------------------------------//
struct Board {
	mut:
	hallway []u8
	slots [][]u8
	steps i64
}

//---------------------------------------------------------------------------//
fn load() !Board {
	mut b:= Board{
		[]u8{len:7},
		[][]u8{len:4,init:[]u8{len:2}},
		0
	}

	lines := os.read_lines(path)!
	//for l in lines {
	//	println(l)
	//}
	b.slots[0][0] = lines[2][3]-'A'[0]+1
	b.slots[1][0] = lines[2][5]-'A'[0]+1
	b.slots[2][0] = lines[2][7]-'A'[0]+1
	b.slots[3][0] = lines[2][9]-'A'[0]+1
	
	b.slots[0][1] = lines[3][3]-'A'[0]+1
	b.slots[1][1] = lines[3][5]-'A'[0]+1
	b.slots[2][1] = lines[3][7]-'A'[0]+1
	b.slots[3][1] = lines[3][9]-'A'[0]+1
	return b
}

//---------------------------------------------------------------------------//
fn(b Board) show(){
	print( b.hallway[0] )
	print( b.hallway[1] )
	print( 0 )
	print( b.hallway[2] )
	print( 0 )
	print( b.hallway[3] )
	print( 0 )
	print( b.hallway[4] )
	print( 0 )
	print( b.hallway[5] )
	println( b.hallway[6] )
	for l in 0..b.slots[0].len{
		print('  ')
		for i in 0..4{
			print( b.slots[i][l] )
			print(' ')
		}
		println('')
	}
	print('Score:')
	println( b.steps )
	println('')
}

//---------------------------------------------------------------------------//
fn(b Board) inplace ( i u8, l u8 ) bool {
   //return b.slots[i][1]==i+1 && (l==1 || b.slots[i][0]==i+1)
   mut ll := i8(b.slots[i].len-1)
   for ll>=l && b.slots[i][ll] == i+1 {
      ll-=1
   }
   return ll<l
}

//---------------------------------------------------------------------------//
fn(b Board) hdrchk ( hi u8, i u8 ) bool {
	mut oi:=-1
	for ii in 0..i+2{
		if b.hallway[ii]>0 {
			oi=ii
		}
	}
	if hi<=oi { return false }
	/*
	01    0
	012   1
	0123  2
	01234 3
	*/
	oi=7
	for ii in i+2..7 {
		if b.hallway[ii]>0 {
			oi=ii
			break
		}
	}
	if hi>=oi { return false }
	/*
    	0 23456
    	1 3456
	2 456
	3 456
    	*/
	return true
}

//---------------------------------------------------------------------------//
fn(mut b Board) sethdr ( hi u8, i u8, l u8 ) bool {
   if b.inplace(i,l) {return false}
   mut oi:=-1
   for ii in 0..i+2 {
      if b.hallway[ii]>0 {
         oi=ii
      }
   }
   if hi<=oi { return false }
	/*
	01    0
	012   1
	0123  2
	01234 3
	*/
   oi=7
   for ii in i+2..7 {
	if b.hallway[ii]>0 {
		oi=ii
		break
	}
   }
   if hi>=oi { return false }
	/*
	0 23456
    	1 3456
	2 456
	3 56
    	*/
	
   if b.hallway[hi]==0 && ((b.slots[i][l]>0 && l==0) || (l==1 && b.slots[i][0]==0 && b.slots[i][1]>0) ) {
	v:= b.slots[i][l]
	b.hallway[hi] = v
	b.slots[i][l]=0
	mut hii:=0;
	if hi==0 {}
	else if hi==6{ hii=10}
	else { hii = 2*hi-1 }
	
	mut steps := math.abs(i64(hii) - i64(2)*i64(i)-2) + i64(l+1)
	//01 2 3 4 56
	//0123456789    2i-1  0 1 2 3 4 5 6
	//--x-x-x-x--        -1 1 3 5 7 9 11
	//  | | | |
	//  0 1 2 3
	//  0 2 4 6
	//  2 4 6 8
	if v > 0 { steps*=1}
	if v > 1 { steps*=10}
	if v > 2 { steps*=10}
	if v > 3 { steps*=10}
	b.steps += steps  
	return true
   }
   return false
}

//---------------------------------------------------------------------------//
fn(mut b Board) gethdr ( hi u8, i u8, l u8 ) i64 {
   if b.hallway[hi]>0 {
      v:= b.hallway[hi]
      b.slots[i][l] = v
      b.hallway[hi] = 0
      mut hii:=0;
      if hi==0 {}
      else if hi==6{ hii=10}
      else { hii = 2*hi-1 }
      mut steps := math.abs(i64(hii) - 2*i64(i)-2) + i64(l+1);
      if v > 0 { steps*=1}
      if v > 1 { steps*=10}
      if v > 2 { steps*=10}
      if v > 3 { steps*=10}
      return steps
   }
   return 0
}

//---------------------------------------------------------------------------//
fn(mut b Board) place( min &i64 ) {
   for _ in 0..4 {
      for i in 0..7 {
	 v:=b.hallway[i]
	 if v>0 {
	    b.hallway[i] = 0
	    ok:= b.hdrchk ( i, v-1 )
	    b.hallway[i] = v 
	    if ok {
	    mut l := i8(b.slots[0].len-1)
	    for l>=0 && b.slots[v-1][l]==v {
	    	l-=1
	    }
	    l0:=l
	    for l>=0 && b.slots[v-1][l]==0 {
	    	l-=1
	    }
	    if l==-1 && l0>=0 {
	    	//b.slots[v-1][l0]==
		b.steps += b.gethdr ( i, v-1, u8(l0) )
	    }
	    
	       /*if b.slots[v-1][0]==0 && (b.slots[v-1][1]==0 || b.slots[v-1][1]==v)  {
		  if b.slots[v-1][1]==0 {
			b.steps += b.gethdr(i,v-1,1)
		  } else {
			b.steps += b.gethdr(i,v-1,0)
		  }
	       }*/
            }
         }
      }   
   }
	
   mut done:=true
   for i in 0..4 {
      if !(i+1==b.slots[i][0] && b.slots[i][0]==b.slots[i][1]) {
         done = false break
      }
   }
   if done && *min > b.steps {
      unsafe{ *min = b.steps }
      //println ( *min )
   }
}

//---------------------------------------------------------------------------//
fn solve ( b Board, min &i64 ) {
        mut bc := Board{b.hallway.clone(), b.slots.clone(),b.steps}
	bc.place ( min )
	if bc.steps > *min { return }
	s := bc.steps
	for level in 0..b.slots[0].len {
	   for slot in 0..4 {
	      for hi in 0..7 {
		 if bc.sethdr ( hi, slot, level ) {
		//if bc.to_halway ( hi, i, l ) {
		    solve ( bc, min )
		    bc.steps = s
		    bc.gethdr ( hi, slot, level )
		//bc.from_hallway( hi, i, l )
		 }
	      }
	   }
        }
}

//---------------------------------------------------------------------------//
pub fn task1() string {
	mut data:=load() or { return term.bright_red("[Error]Load:" + err.str()) }
	//slots.show ( )
	ans := i64(0x7fffffffffffffff)	// max signed int 64bit
	solve ( data, &ans )

	return ans.str()
}

//---------------------------------------------------------------------------//
pub fn task2() string {
	mut data:=load() or { return term.bright_red("[Error]Load:" + err.str()) }
	//#D#C#B#A#
	//#D#B#A#C#
	data.slots[0].insert(1,4)
	data.slots[1].insert(1,2)
	data.slots[2].insert(1,1)
	data.slots[3].insert(1,3)
	data.slots[0].insert(1,4)
	data.slots[1].insert(1,3)
	data.slots[2].insert(1,2)
	data.slots[3].insert(1,1)
// 15156 to low
	data.show()
	ans := i64(0x7fffffffffffffff)
	solve( data, &ans )
	return ans.str()
}

//---------------------------------------------------------------------------//
