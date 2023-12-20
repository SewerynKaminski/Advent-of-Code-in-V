module day19

import aoc
import term

const path='modules/year2023/day19/input'

struct Rule {
   cat  u8
   op   u8
   val  i16
   next string
}

struct Work{
   rules []Rule
}

struct Rate{
   x i64
   m i64
   a i64
   s i64
}

struct Data {
mut:
   works map[string]Work
   rates []Rate
}

struct Range {
mut:
   r bool
   p []i16 = [i16(1),4001]
}

fn (r Range) clone() Range {
   return Range { r.r, r.p.clone() }
}

fn (r Range) len() i64 {   
   mut sum:=i64(0)
   for i:=int(r.r); i < r.p.len-1; i+=2 {
      sum += r.p[i+1] - r.p[i]
   }
   return sum
}

fn (mut r Range) gt ( v i16 ) {
   mut rev:= r.r
   for i:=0; i < r.p.len-1; i++ {
      if r.p[i] <= v && v < r.p[i+1] {
         if !rev {
            r.p[i] = v + 1
            r.p.delete_many( 0, i )
            if r.p[0]>1 {
               r.p.insert(0,1)
               r.r = true
            } else {
               r.r = false
            }
            break
         } else {
	    r.p.delete_many( 1, i-1 )
            r.r = true
            break
         }
      }
      rev = !rev
   }
}

fn (mut r Range) lt ( v i16 ) {
   mut rev:= r.r
   for i:=0; i < r.p.len-1; i++ {
      if r.p[i] <= v && v < r.p[i+1] {
         if !rev {
            r.p[i+1] = v
            r.p.delete_many( i+2, r.p.len-i-2 )
            if r.p.last()!=4001 { r.p << 4001 }
            break
         } else {
            r.p.delete_many( i+2, r.p.len-i-2 )
            if r.p.last()!=4001 { r.p << 4001 }
            break
         }
      }
      rev = !rev
   }
}

fn load() !Data {
   lines := aoc.read_lines ( path )!
   mut data:= Data { map[string]Work{}, []Rate{} }

   // load workflows
   mut i:=0
   for ;i<lines.len; i++ {
      line:=lines[i]
      if line.len==0 { break }
      l:= line[0..line.len-1]    
      s:= l.split('{')
      name:= s[0]
      w:= s[1].split( ',' )
      mut workflow:= []Rule{}
      for q in w {
         // 'x<0:aaa'
         if q.contains(':') {
            e:= q.split(':')
            workflow << Rule { q[0], q[1], e[0][2..].i16(), e[1] }
         } else {
            workflow << Rule { 0, 0, 0, q }
         }        
      }
      data.works[name] = Work { workflow }
   }

   // load rateings
   for i++; i < lines.len; i++ {
      s:= lines[i].substr_ni(1,-1).split ( ',' )
      data.rates << Rate { s[0][2..].i64(), s[1][2..].i64(), s[2][2..].i64(), s[3][2..].i64() }
   }

   return data
}

fn check( works map[string]Work, r Rate ) bool {
   mut work_name:='in'

   for true {
      if work_name=='A' { return true }
      if work_name=='R' { return false }
      if work:=works[work_name] {
         for rule in work.rules {
            v := if rule.cat==`x` { r.x }
                 else if rule.cat==`m` { r.m }
                 else if rule.cat==`a` { r.a }
                 else if rule.cat==`s` { r.s }
                 else { work_name = rule.next break }
            if rule.op==`<` && v < rule.val { work_name = rule.next break }
            if rule.op==`>` && v > rule.val { work_name = rule.next break }
         }
      }
   }

   return false
}

pub fn task1() string {
   data:= load() or { return term.bright_red("[Error]Load:"+err.str()) }
   mut ans:=i64(0)

   for rate in data.rates {
      if check ( data.works, rate ) {
         ans += rate.x + rate.m + rate.a + rate.s
      }
   }

   return ans.str()
}

fn(rule Rule) applay ( mut r Range ) {
   if rule.op==`<` { r.lt ( rule.val ) }
   if rule.op==`>` { r.gt ( rule.val ) } 
}

fn(rule Rule) unapplay ( mut r Range ) {
   if rule.op==`<` { r.gt ( rule.val-1 ) }
   if rule.op==`>` { r.lt ( rule.val+1 ) } 
}

fn count ( works map[string]Work, name string, x Range, m Range, a Range, s Range ) i64 {
   if name == 'A' { return x.len() * m.len() * a.len() * s.len() }
   if name == 'R' { return 0 }

   work:= works[name]
   mut sum:= i64(0)

   mut rx:= x.clone()
   mut rm:= m.clone()
   mut ra:= a.clone()
   mut rs:= s.clone()

   for rule in work.rules {
      mut rr:= Range{}
      match rule.cat {
         `x` { rr = rx.clone() rule.applay ( mut rx ) }
         `m` { rr = rm.clone() rule.applay ( mut rm ) }
         `a` { rr = ra.clone() rule.applay ( mut ra ) }
         `s` { rr = rs.clone() rule.applay ( mut rs ) } 
         else {}
      }
      
      sum += count ( works, rule.next, rx, rm, ra, rs )

      rule.unapplay ( mut rr )
      match rule.cat {
         `x` { rx = rr }
         `m` { rm = rr }
         `a` { ra = rr }
         `s` { rs = rr }
         else {}
      }
   }
   return sum
}

pub fn task2() string { 
   data:= load() or { return term.bright_red("[Error]Load:"+err.str()) }
   
   ans:= count ( data.works, 'in', Range{}, Range{}, Range{}, Range{} )

   return ans.str()
}

