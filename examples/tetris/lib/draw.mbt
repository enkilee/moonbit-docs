type Canvas_ctx

fn set_stroke_color(self : Canvas_ctx, color : Int) = "canvas" "set_stroke_color"

fn set_line_width(self : Canvas_ctx, width : Double) = "canvas" "set_line_width"

fn stroke_rect(self : Canvas_ctx, x : Int, y : Int, width : Int, height : Int) = "canvas" "stroke_rect"

fn fill_rect(self : Canvas_ctx, x : Int, y : Int, width : Int, height : Int) = "canvas" "fill_rect"

fn set_fill_style(self : Canvas_ctx, color : Int) = "canvas" "set_fill_style"

fn draw_game_over(self : Canvas_ctx) = "canvas" "draw_game_over"

pub fn draw(canvas : Canvas_ctx, tetris : Tetris) -> Unit {
  let mut c = 0

  // draw background
  while c < grid_col_count {
    let color = if c % 2 == 0 {
      0
    } else {
      1
    }
    canvas.set_fill_style(color)
    canvas.fill_rect(c, 0, 1, grid_row_count)
    c = c + 1
  }
  draw_piece(canvas, tetris.grid, (0, 0))
  draw_piece(canvas, List::from_array(tetris.piece_shape), (tetris.piece_x, tetris.piece_y))
  if tetris.dead {
    canvas.draw_game_over()
  }
}

pub fn draw_piece(canvas : Canvas_ctx, matrix : List[Array[Int]],
        offset : (Int, Int)) -> Unit {
  fn go(l : List[Array[Int]], r : Int, canvas : Canvas_ctx) {
    match l {
      Cons(v, n) => {
        let mut c = 0
        while c < v.length() {
          if v[c] == 0 {
            c = c + 1
            continue
          }
          canvas.set_fill_style(v[c] + 1)
          canvas.fill_rect(offset.0 + c, offset.1 + r, 1, 1)
          canvas.set_stroke_color(0)
          canvas.set_line_width(0.1)
          canvas.stroke_rect(offset.0 + c, offset.1 + r, 1, 1)
          c = c + 1
        }
        go(n, r + 1, canvas)
      }
      Nil => ()
    }
  }

  go(matrix, 0, canvas)
}

