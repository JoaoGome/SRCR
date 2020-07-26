import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;
import java.lang.String;
import java.util.HashMap;
import java.util.*;

public class writer
{
	public static void main (String args[]) throws FileNotFoundException
	{
		HashMap <Integer,cidade> cidades = new HashMap <>();
		File file = new File ("/Users/Jota/Desktop/SRCR/cidades.csv");
		Scanner sc = new Scanner (file);

		while (sc.hasNextLine())
		{
			String data = sc.nextLine ();
			String [] wtv = data.split(",");
			StringBuilder sb = new StringBuilder();
			sb.append("cidade(");
			sb.append(wtv[0]);
			sb.append(",");
			sb.append("'" + wtv[1] + "'");
			sb.append(",");
			sb.append(wtv[2]);
			sb.append(",");
			sb.append(wtv[3]);
			sb.append(",");
			sb.append("'" + wtv[4] + "'");
			sb.append(",");
			sb.append("'" + wtv[5] + "'");
			sb.append(",");
			sb.append("'No'");
			sb.append(",");
			sb.append("'No'");
			sb.append(").");
			System.out.println(sb.toString());


			cidade nova = new cidade (Integer.parseInt(wtv[0]), Double.parseDouble(wtv[2]), Double.parseDouble(wtv[3]));
			cidades.put(Integer.parseInt(wtv[0]),nova);

		}

		for (int key: cidades.keySet())
		{
			for (Map.Entry <Integer,cidade> entry: cidades.entrySet())
			{
				if (key != entry.getKey())
				{
					cidade y = entry.getValue();
					cidade atual = cidades.get(key);
					if(atual.distancia(y) < 0.2)
					{
						StringBuilder sb = new StringBuilder();
						sb.append("arco(");
						sb.append(key);
						sb.append(",");
						sb.append(entry.getKey());
						sb.append(",");
						sb.append(atual.distancia(y));
						sb.append(").");
						System.out.println(sb.toString());
					}
				}
			}
		}

		sc.close();
	}
}
