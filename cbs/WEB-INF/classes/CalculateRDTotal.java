package com.cbs;
public class CalculateRDTotal
{
public static double calculate(double premium,double interest,int month)
{
double sum=0.0d;
	for(int i=1;i<=month;i++)
	{
		if(i%3==0)
		{
			sum=sum+premium;
			double interest1=sum*(double)(interest/100.0d);
			sum=sum+interest1;
			//System.out.println(sum+ " and "+interest);
			
			
		}
		else
		{
			sum=sum+premium;
			//System.out.println(i%3);
			//System.out.println(sum);
		}
	}

return(sum);
}
}


