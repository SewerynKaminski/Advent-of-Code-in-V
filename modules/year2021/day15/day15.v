module day15

import os
import term

const int32_max = 0x7fffffff

//---------------------------------------------------------------------------//
fn load ( )![]string {
   data := os.read_lines('modules/year2021/day15/input')!

   return data
}

//---------------------------------------------------------------------------//
fn min ( a int, b int ) int {
   if a<b{ return a}
   return b
}

//---------------------------------------------------------------------------//
fn traverse ( d []string ) u64 {
    mut a := []int{}
    width := d.len

    for l in d {
        for c in l {
           a << c - 48
        }
    }

    for i := width - 1; i > 0; i-- {
        a[ ( i - 1 ) *width + width - 1] += a[i * width + width - 1 ]
        a[ ( width - 1 ) *width + i - 1] += a[ ( width - 1 ) * width + i]
    }

    for y := width - 2; y >= 0 ; y-=1 {
        for x := width - 2; x >= 0; x-=1 {
            right := a[ y    * width + x + 1]
            down := a[ ( y + 1 ) * width + x    ]
            a[ y * width + x ] += min ( right, down )
        }
    }

    return u64(a[0])
}

//---------------------------------------------------------------------------//
pub fn task1() string {
   data:= load() or { return term.bright_red("[Error]Load:"+err.str())}

   ans := traverse ( data ) - data[0][0] + 48;

   return ans.str()
}

//---------------------------------------------------------------------------//
struct QQ {
   d int
   x int
   y int
}

//---------------------------------------------------------------------------//
fn dijkstra ( d [][]u8 ) int {
    mut q := []QQ{}         // kolejka
    n := d.len
    mut dist := [][]int{ len:n, init: []int{len:n, init:int32_max} }

    dist[0][0] = 0

    mut c := QQ{}
    pc := &c
    mut pdist := &dist
    mut pq := &q

    cmp := fn[mut pdist,pc,mut pq, d]( a int, b int ) {    	
        l := (*pdist)[pc.y][pc.x] + d[pc.y + b][pc.x + a]
        if l < (*pdist)[pc.y + b][pc.x + a] {
            (*pdist)[pc.y + b][pc.x + a] = l
            pq << QQ{ l, pc.x + a, pc.y + b}
        }
    }

    q << QQ{}
    for q.len>0 {
        c = q.pop()
        if c.x == n - 1 && c.y == n - 1 { return dist[n - 1][n - 1] }        
        
        if c.x + 1 <  n { cmp ( 1,  0 ) }
        if c.x - 1 >= 0 { cmp (-1,  0 ) }
        if c.y + 1 <  n { cmp ( 0,  1 ) }
        if c.y - 1 >= 0 { cmp ( 0, -1 ) }

        q.sort(a.d>b.d)
    }

    return dist[n - 1][n - 1]
}

//---------------------------------------------------------------------------//
fn incv ( s []u8 ) []u8{
   mut ret:=[]u8{len: s.len}
   for i,c in s {
      ret[i] = c+1
      if ret[i] > 9 { ret[i] = 1}
   }
   return ret
}

//---------------------------------------------------------------------------//
fn inca ( mut d [][]u8 ) {
   for mut l in d {
      l = incv ( l )
   }
}

//---------------------------------------------------------------------------//
pub fn task2() string { 
   lines := load ( ) or { return term.bright_red ( "[Error]Load:" + err.str ( ) ) }
   mut data := [][]u8{}
   for line in lines {
      mut buf := []u8{len:line.len,init:line[index]-48}
      data << buf
   }

   for mut l in data {
      l1 := incv ( l )
      l2 := incv ( l1 )
      l3 := incv ( l2 )
      l4 := incv ( l3 )
      l << l1
      l << l2
      l << l3
      l << l4
   }
   
   mut nd := [][]u8{}
   for _ in 0..5 {
       nd << data
       inca ( mut data )
   }

   ans := dijkstra ( nd )

   return ans.str()
}

