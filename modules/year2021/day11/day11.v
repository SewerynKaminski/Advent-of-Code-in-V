module day11

import os

const path = 'modules/year2021/day11/input'

//---------------------------------------------------------------------------//
fn load ( ) ![][]u8 {
    mut file := os.open_file ( path, 'r' )!
    mut data := [][]u8{}
    mut buf := []u8{len:1024}

    mut l:= file.read_bytes_into_newline( mut buf ) or {println(err)}-1
    for l>0 {
        data << buf[0..l].clone()
        l = file.read_bytes_into_newline( mut buf ) or {0}-1
    }
    return data
}

//---------------------------------------------------------------------------//
fn show ( data [][]u8 ) {
   for l in data {
      println ( l )
   }
   println ( '' )
}

//---------------------------------------------------------------------------//
fn inc ( mut data [][]u8 ) {
    for mut l in data {
        for mut o in l {
            o++
        }
    }
}

//---------------------------------------------------------------------------//
fn flash ( mut data [][]u8 ) i32 {
    mut cnt := 0
    mut flash:=true
    for flash {
        flash = false
        for r in 0..10 {
            for c in 0..10 {
                if data[r][c] > 57 {
                    data[r][c] = 48;
                    cnt+=1
                    if r > 0 &&          data[r - 1][c    ] != 48 { data[r - 1][c    ]+=1}
                    if r > 0 && c < 9 && data[r - 1][c + 1] != 48 { data[r - 1][c + 1]+=1}
                    if c < 9 &&          data[r    ][c + 1] != 48 { data[r    ][c + 1]+=1}
                    if r < 9 && c < 9 && data[r + 1][c + 1] != 48 { data[r + 1][c + 1]+=1}
                    if r < 9 &&          data[r + 1][c    ] != 48 { data[r + 1][c    ]+=1}
                    if r < 9 && c > 0 && data[r + 1][c - 1] != 48 { data[r + 1][c - 1]+=1}
                    if c > 0 &&          data[r    ][c - 1] != 48 { data[r    ][c - 1]+=1}
                    if r > 0 && c > 0 && data[r - 1][c - 1] != 48 { data[r - 1][c - 1]+=1}
                    flash = true
                }
            }
        }
    }

    return cnt
}

//---------------------------------------------------------------------------//
pub fn task1() string {
    mut ans := 0

    mut data := load ( ) or { return "[Error]Load"}

    //show ( data )

    for _ in 0..100 {
        inc ( mut data )
        ans += flash ( mut data )
    }

    return ans.str()
}

pub fn task2() string { 
   mut ans := 0

   mut data := load () or { return "[Error]Load"}

   for  {
      ans+=1
      inc ( mut data )
      if 100 == flash ( mut data ) {
         break
      }
   }
   
   return ans.str()
}

