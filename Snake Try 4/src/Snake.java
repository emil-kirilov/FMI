import java.awt.Point;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.KeyEvent;
import java.awt.event.KeyListener;
import java.util.ArrayList;
import java.util.Random;

import javax.swing.JFrame;
import javax.swing.Timer;


public class Snake implements ActionListener, KeyListener
{
	public static Snake snake;
	
	//public Timer getTimer(){return timer;}
	//public void setTimer(Timer t){timer = t;}
	
	public JFrame jframe;
	
	public RenderPanel renderPanel;
	
	public Timer timer = new Timer(50,this);
	
	public ArrayList<Point> snakeParts = new ArrayList<Point>();
	
	public int score = 0, tailLength = 0, time = 0, snakeLength = 1, cherriesEaten = 0;
	
	//public int getScore() {
	//	return score;
	//}
	//public void setScore(int score) {
	//	this.score = score;
	//}

	public Point head, cherry;
	
	public Random random;
	
	public boolean over = false, paused = false;

	boolean showGameOver = false;
	
	int direction = 0;
	
	public Snake()
	{
		jframe = new JFrame("Snake");
		jframe.setSize(1206,929);
		jframe.setResizable(false);
		jframe.setVisible(true);
		jframe.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		jframe.add(renderPanel = new RenderPanel());
		jframe.addKeyListener(this);

	
		startGame();
	}
	
	public void keyPressed(KeyEvent e)
	{
		int c = e.getKeyCode();
		if (c == KeyEvent.VK_UP && direction !=KeyEvent.VK_DOWN )
		{
			direction = KeyEvent.VK_UP;
		}
		if (c == KeyEvent.VK_DOWN && direction !=KeyEvent.VK_UP)
		{
			direction = KeyEvent.VK_DOWN;
		}
		if (c == KeyEvent.VK_LEFT && direction !=KeyEvent.VK_RIGHT)
		{	
			direction = KeyEvent.VK_LEFT;
		}
		if (c == KeyEvent.VK_RIGHT && direction !=KeyEvent.VK_LEFT)
		{
			direction = KeyEvent.VK_RIGHT;
		}
		if (c == KeyEvent.VK_SPACE)
		{
			if (over)
			{
				startGame();
			}
			else
			{
				paused = !paused;
				if(paused)
				{
					timer.stop();
				}
				else
				{
					timer.restart();
				}
			}
		}
	}
	
	public void keyTyped(KeyEvent e){}
	public void keyReleased(KeyEvent e){}

	
	public void actionPerformed(ActionEvent e)
	{ 
		time++;
		renderPanel.repaint();
		
		snakeParts.add(new Point(head.x, head.y));
		
		if (direction == KeyEvent.VK_UP)
		{
			if (head.y - 1 >= 0 && noTailAt(head.x, head.y - 1))
			{
				head = new Point(head.x, head.y - 1);
			}
			else
			{
				over = true;

			}
		}

		if (direction == KeyEvent.VK_DOWN)
		{
			if (head.y + 1 < 60 && noTailAt(head.x, head.y + 1))
			{
				head = new Point(head.x, head.y + 1);
			}
			else
			{
				over = true;
			}
		}

		if (direction == KeyEvent.VK_LEFT)
		{
			if (head.x - 1 >= 0 && noTailAt(head.x - 1, head.y))
			{
				head = new Point(head.x - 1, head.y);
			}
			else
			{
				over = true;
			}
		}

		if (direction == KeyEvent.VK_RIGHT)
		{
			if (head.x + 1 < 80 && noTailAt(head.x + 1, head.y))
			{
				head = new Point(head.x + 1, head.y);
			}
			else
			{
				over = true;
			}
		}
		
		if (snakeParts.size() > tailLength)
		{
			snakeParts.remove(0);

		}

		if (cherry != null)
		{
			if (head.equals(cherry))
			{
				score += 10;
				tailLength += 5;
				snakeLength += 5;
				cherriesEaten++;
				
				boolean cherryOnSnake = true;
				while(cherryOnSnake)
				{
				cherryOnSnake = false;
				cherry.setLocation(random.nextInt(79), random.nextInt(57));
				for (Point point : snakeParts)
				{
					if (point.equals(cherry))
					{
						cherryOnSnake = true;
					}
				}
				}
			}
		}
		
	}
	
	
	public static void main(String[] args)
	{
		snake = new Snake();
	}
	
	public boolean noTailAt(int x, int y)
	{
		for (Point point : snakeParts)
		{
			if (point.equals(new Point(x, y)))
			{
				return false;
			}
		}
		return true;
	}
	
	public void startGame()
	{
		over = false;
		paused = false;
		time = 0;
		score = 0;
		tailLength = 0;
		head = new Point(40, 30);
		random = new Random();
		snakeParts.clear();
		cherry = new Point(random.nextInt(79), random.nextInt(57));
		timer.start();
	}
}
