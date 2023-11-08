module day04

struct BingoBoard {
  mut:
    board     []i32 = []i32{}
    last_move i32   = -1
    enable   bool  = true
}

fn(mut this BingoBoard) set_board_from ( s string ) {
   t := s.split(' ')
   this.board.clear()
   for v in t {
      if v.len > 0 {
         this.board << i32(v.int())
      }
   }
}

fn(mut this BingoBoard) mark ( value i32 ) {
   if this.enable {
      for mut cell in this.board {
         if *cell == value {
            cell = -*cell - 1 // marked number
            this.last_move = value
         }
      }
   }
}

fn(this BingoBoard) wins() bool{
   if !this.enable {
	return false
   }

   if this.board.len==0 {
	return false
   }

   for i := 0; i < 5; i ++ {
      if this.board[0 + i * 5] < 0 &&
         this.board[1 + i * 5] < 0 &&
         this.board[2 + i * 5] < 0 &&
         this.board[3 + i * 5] < 0 &&
         this.board[4 + i * 5] < 0 {
            return true
      }
   }
   for i := 0; i < 5; i++ {
      if this.board[0 * 5 + i] < 0 &&
         this.board[1 * 5 + i] < 0 &&
         this.board[2 * 5 + i] < 0 &&
         this.board[3 * 5 + i] < 0 &&
         this.board[4 * 5 + i] < 0 {
            return true
      }
   }
   return false
}

fn(this BingoBoard) show(){
   mut i := 0
   for v in this.board {
       i+=1
       print ( "${v:2} " )
       if i == 5 {
           println('')
           i = 0
       }
   }
   println('')
}

fn(this BingoBoard) last_move() i32{
	return this.last_move
}

fn(this BingoBoard) score() i32 {
  mut sum := 0
  for v in this.board {
        if v > 0 {
            sum += v
        }
    }
    return i32(sum * this.last_move)
}

fn(mut this BingoBoard) reset(){
   for mut cell in this.board {
        if *cell < 0 {
            cell = -*cell - 1 // unmark number
            this.last_move = -1
        }
    }
}

fn(mut this BingoBoard) set_enabled ( e bool ){
	this.enable = e
}

fn(this BingoBoard) enabled() bool{
	return this.enable
}

