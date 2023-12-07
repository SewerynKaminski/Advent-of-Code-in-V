module day07

import os
import term
import math.stats

const path='modules/year2023/day07/input'
           //'modules/year2023/day07/input_test'
struct Ss{
mut:
   hand []u8
   bid i64
}

fn load() ![]Ss {
   mut data := []Ss {}
   mut line := []u8{len:1024}
   mut file := os.open_file ( path, 'r' )!

   mut l := file.read_bytes_into_newline ( mut line ) or {0}-1
   for l>0 {
      s := line[0..l].bytestr().split( ' ' )
      mut b := []u8{}
      for c in s[0] {
         if c>='2'[0] && c<='9'[0]{ b << c-48 }
         if c=='A'[0] { b << 14 }
         if c=='K'[0] { b << 13 }
         if c=='Q'[0] { b << 12 }
         if c=='J'[0] { b << 11 }
         if c=='T'[0] { b << 10 }
      }
      data << Ss{hand: b, bid: s[1].i64() }

      l = file.read_bytes_into_newline( mut line ) or {0}-1
   }
   file.close()

   return data
}

enum Type {
   five_of_a_kind
   four_of_a_kind
   full_house
   three_of_a_kind
   two_pair
   one_pair
   high_card
}

fn type_of_hand ( hand []u8 ) Type {
   mut cards := [u8(0),0,0,0,0,0,0,0,0,0,0,0,0,0,0]
  
   for card in hand {
      cards[card]++
   }
   mut c := cards.filter ( fn(e u8)bool{return e==5} ).len
   if c==1 { return Type.five_of_a_kind }
   c = cards.filter ( fn(e u8)bool{return e==4} ).len
   if c==1 { return Type.four_of_a_kind}
   c = cards.filter( fn(e u8)bool{return e==3}  ).len
   if c==1 {
      c = cards.filter ( fn(e u8)bool{return e==2}  ).len
      if c==1 { return Type.full_house} 
      else { return Type.three_of_a_kind}
   }
   c = cards.filter ( fn(e u8)bool{return e==2} ).len
   if c==2 { return Type.two_pair }
   if c==1 { return Type.one_pair }

   return Type.high_card
}

fn type_of_hand2( hand []u8 ) Type {
   mut cards := [u8(0),0,0,0,0,0,0,0,0,0,0,0,0,0,0]
   for card in hand {
      cards[card]++
   }
   if cards[11] > 0 { // Joker
      j:=cards[11]
      cards[11]=0
      cards[stats.max_index(cards)] += j
   }

   mut c := cards.filter ( fn(e u8)bool{return e==5} ).len
   if c==1 { return Type.five_of_a_kind }
   c = cards.filter ( fn(e u8)bool{return e==4} ).len
   if c==1 { return Type.four_of_a_kind}
   c = cards.filter( fn(e u8)bool{return e==3}  ).len
   if c==1 {
      c = cards.filter ( fn(e u8)bool{return e==2}  ).len
      if c==1 { return Type.full_house}
      else { return Type.three_of_a_kind}
   }
   c = cards.filter ( fn(e u8)bool{return e==2} ).len
   if c==2 { return Type.two_pair }
   if c==1 { return Type.one_pair }

   return Type.high_card   
}

pub fn task1() string {
   mut ans:=i64(0)
   mut data := load() or { return term.bright_red("[Error]open:"+err.str()) }
   //for row in data {
   //   println ( type_of_hand ( row.hand ) )
   //}

   data.sort_with_compare ( fn(a &Ss,b &Ss)int {
	r:= int(type_of_hand(a.hand))-int(type_of_hand(b.hand))
        if r==0 {
	   for i,v in a.hand{ 
	      if v!=b.hand[i]{ return int(b.hand[i])-int(v)}
           }
        }
	return r
     } )

   for i,row in data {
      //print ( type_of_hand ( row.hand ) )
      //print ( row.hand )
      //println ( row.bid * (data.len-i) )
      ans += row.bid * (data.len-i)
   }

   return ans.str()
}

pub fn task2() string { 
   mut ans:=i64(0)
   mut data := load() or { return term.bright_red("[Error]open:"+err.str()) }
   data.sort_with_compare ( fn(a &Ss,b &Ss)int {
        r:= int(type_of_hand2(a.hand))-int(type_of_hand2(b.hand))
        if r==0 {
           for i,v in a.hand{
              if v!=b.hand[i] {
                 mut va := if v==11 { 1 } else { int(v) }
                 mut vb := if b.hand[i]==11 { 1 } else { int(b.hand[i]) }
                  
	         return vb - va
	      }
           }
        }
        return r
     } )

   for i,row in data {
      ans += row.bid * (data.len-i)
   }

   return ans.str()
}
