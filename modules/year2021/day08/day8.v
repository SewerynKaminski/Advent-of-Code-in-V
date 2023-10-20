module day08

import os

const path = 'modules/year2021/day8/input'

//---------------------------------------------------------------------------//
struct Display {
   patterns []string
   outputs  []string
}

//---------------------------------------------------------------------------//
fn load ( file os.File ) []Display {
    mut data := []Display{};

    mut buf:=[]u8{len:1024}
    mut l := file.read_bytes_into_newline( mut buf ) or {0}-1
    for l>0 {
	//l = file.read_bytes_into_newline( mut buf ) or {0}-1
	t := buf[0..l].bytestr().split(' | ')
	mut p := t[0].split(' ')
	for mut pi in p {
	   mut pib := pi.bytes()
	   pib.sort()
	   pi = pib.bytestr()
	}

	mut o := t[1].split(' ')	
	for mut oi in o {
	   mut oib := oi.bytes()
	   oib.sort()
	   oi = oib.bytestr()
	}

        if p.len == 10 {
            data << Display{patterns:p, outputs:o}
	}
	l = file.read_bytes_into_newline( mut buf ) or {0}-1
    }
    return data
}

//---------------------------------------------------------------------------//
pub fn task1() string {
   mut ans := 0

   mut file := os.open_file ( path, 'r' ) or {
      return "[Error]open"
   }

   data := load ( file )

   for display in data {
      for o in display.outputs {
         if o.len == 2 || o.len == 4 || o.len == 7 || o.len == 3 {
            ans += 1
         }
      }
   }
   return ans.str()
}

//---------------------------------------------------------------------------//
fn cnt ( a string, b string ) i32 {
   mut r := 0
   ab:=a.bytes()
   bb:=b.bytes()
   for c in bb {
       r += u8(c in ab)
   }
   return r
}

//---------------------------------------------------------------------------//
fn contains ( a string, b string ) bool {
   ab := a.bytes()
   for c in b.bytes() {
        if c !in ab {
	   return false
	}
   }

   return true
}

//---------------------------------------------------------------------------//
pub fn task2() string { 
   mut ans := 0

   mut file := os.open_file ( path, 'r' ) or {
      return "[Error]open"
   }

   data := load ( file )

   for display in data {
       mut digits := []string{len:10}
       for s in display.patterns {
           if s.len == 2 { digits[1] = s }
           else if s.len == 4 { digits[4] = s }
           else if s.len == 3 { digits[7] = s }
           else if s.len == 7 { digits[8] = s }
       }
       for s in display.patterns {
           if s.len == 5 { // 2 lub 3 lub 5
               // 235 => tylko 3 zawiera 1 lub 7 w calosci
               //  25 => tylko 5 zawiera >4
               //   2 => tylko 2
               if contains ( s, digits[1] ) {
                   digits[3] = s
               } else { // 2 lub 5
                    if cnt ( s, digits[4] ) == 3 {
                        digits[5] = s
                    } else {
                        digits[2] = s
                    }
                }
            } else if s.len == 6 { // 0 lub 6 lub 9
                if !contains ( s, digits[1] ) {
                    digits[6] = s
                } else { // 0 lub 9
                    if cnt ( s, digits[4] ) == 3 {
                        digits[0] = s
                    } else {
                        digits[9] = s
                    }
                }
            }
        }

       mut num := 0
       for o in display.outputs {
           for i in  0..10 {
               if digits[i] == o {
                   num = 10 * num + i
               }
           }
       }
       ans += num
   }

   return ans.str()
}

