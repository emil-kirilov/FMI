import java.awt.Color;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JPanel;


public class difficulty {
	
	private JFrame jframe;
	private JPanel jpanel;
	private JButton easy;
	private JLabel leasy;
	
	public void dif(){
		jframe = new JFrame("set diffuculty");
		jframe.setVisible(true);
		jframe.setSize(600,400);
		jframe.setResizable(false);
		jframe.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		
		jpanel = new JPanel();
		jpanel.setBackground(Color.WHITE);
	
		jframe.add(jpanel);
		
		easy = new JButton("Easy");
		leasy = new JLabel("snake wont die but reappear on the opposite side when it reaches the end of the screen");
		jpanel.add(easy);
		jpanel.add(leasy);
	
	}
	
	public difficulty(){
		dif();
	}
	
	public static void main(String args[] )
	{
		new difficulty();
	}
	
}

