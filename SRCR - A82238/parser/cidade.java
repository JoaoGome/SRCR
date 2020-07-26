import java.lang.Math;

public class cidade
{
	public int id;
	public double latitude;
	public double longitude;

	public cidade (int id, double latitude, double longitude)
	{
		this.id = id;
		this.latitude = latitude;
		this.longitude = longitude;
	}

	public String toString ()
	{
		StringBuilder sb = new StringBuilder();
		sb.append(id);
		sb.append(" ");
		sb.append(latitude);
		sb.append(" ");
		sb.append(longitude);
		return sb.toString();
	}

	// funcao que calcula a distancia à cidade x2
	public double distancia (cidade x2)
	{
		double distancia = Math.sqrt (Math.pow(this.latitude - x2.latitude,2) + Math.pow(this.longitude - x2.longitude,2));
		return distancia;
	}

	
}
