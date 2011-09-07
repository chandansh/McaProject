package com.magicon;
public class Product
{
private String p_id;
private String p_name;
private String p_cat;
private String p_brand;
private double p_price;
private int p_qty;
private String p_image;
private double total;

public Product()
{
p_id="";
p_name="";
p_cat="";
p_brand="";
p_price=0.0;
p_qty=0;
p_image="";
total=(double)p_qty*p_price;
}


public Product(String p_id,String p_name,String p_cat,String p_brand,Double p_price,int p_qty,String p_image)
{
this.p_id=p_id;
this.p_name=p_name;
this.p_cat=p_cat;
this.p_brand=p_brand;
this.p_price=p_price;
this.p_qty=p_qty;
this.p_image=p_image;
this.total=(double)p_qty*p_price;
}

public String getP_id()
{
return p_id;
}

public String getP_name()
{
return p_name;
}

public String getP_cat()
{
return p_cat;
}

public String getP_brand()
{
return p_brand;
}

public double getP_price()
{
return p_price;
}

public int getP_qty()
{
return p_qty;
}

public String getP_image()
{
return p_image;
}

public double getTotal()
{
return total;
}

public String toString()
{
return p_id+"\n"+p_name+"\n"+p_cat+"\n"+p_brand+"\n"+p_price+"\n"+p_qty+"\n"+p_image+"\n"+total;
}

}
