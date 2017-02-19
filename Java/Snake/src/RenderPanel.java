import java.awt.Color;
import java.awt.Graphics;
import java.awt.Point;

import javax.swing.ImageIcon;
import javax.swing.JPanel;

public class RenderPanel extends JPanel {
	/**
	 * 
	 */
	private static final long serialVersionUID = -1015558200090253783L;


	
	protected void paintComponent (Graphics g)
	{
		super.paintComponent(g);
		Snake snake = Snake.snake;
		g.setColor(Color.BLACK);
		g.fillRect(0,0,1200,900);
		
		g.setColor(Color.RED);
		for (Point point : snake.snakeParts)
		{
			g.fillRect(point.x * 15, point.y * 15, 15, 15);
		}
		g.fillRect(snake.head.x * 15, snake.head.y * 15, 15, 15);
		
		g.setColor(Color.BLUE);
		g.fillRect(snake.cherry.x * 15, snake.cherry.y * 15, 15, 15);
		
		g.setColor(Color.WHITE);
		g.drawString("Score:" + snake.score, 20, 20);
		g.drawString("Time:" + snake.time/20, 20, 33);
		g.drawString("Size:" + snake.snakeLength, 20, 46);
		g.drawString("Cherries eaten:" + snake.cherriesEaten, 20, 59);
		
		ImageIcon i = new ImageIcon("C:\\Users\\Emil\\Desktop\\GameOver.png");
		if(snake.over)
		{
			snake.timer.stop();
			snake.direction = 0;
			snake.score = 0;
			snake.cherriesEaten = 0;
			snake.snakeLength = 1;
			i.paintIcon(this,g,392,376);
		}
	}
}
