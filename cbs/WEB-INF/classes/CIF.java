package com.cbs;

import java.io.*;
import java.sql.*;
import com.oreilly.servlet.MultipartRequest;
import java.util.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class CIF 
{
	CBSBean bean=new CBSBean();
	FileUpload TheBean=new FileUpload();
public String createNonPersonalCIF(HttpServletRequest request,HttpSession session, String branch)throws Exception 
{
	

	
	String msg="message";
   	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;

	try
	{  
	if(request.getContentType()!=null && request.getContentType()!="")
	{
	String serverPath = session.getServletContext().getRealPath("//");
    	String filePath = serverPath + "//temp_images";
    	MultipartRequest multi = new MultipartRequest(request, filePath, 1 * 1024 * 1024);
    
    	String cust_type=multi.getParameter("cust_type");
	String company_name=multi.getParameter("company_name");
	String relation=multi.getParameter("relation");
	String relation_name=multi.getParameter("relation_name");
	
	String year=multi.getParameter("year");
	String month=multi.getParameter("mon");
	String date=multi.getParameter("date");
	//date of Establishment
	String doe=year+"-"+month+"-"+date;
	
	
	String address=multi.getParameter("address");
	String city=multi.getParameter("city");
	String pincode=multi.getParameter("pincode");
	String state=multi.getParameter("state");
	String country=multi.getParameter("country");
	String introducer_cif=multi.getParameter("introducer_cif");
	String pan_no=multi.getParameter("pan_no");
	String emailid=multi.getParameter("emailid");
	
	
		
	
	//first id
	String id1_type=multi.getParameter("id1_type");
	String id1_id_issued_at=multi.getParameter("id1_id_issued_at");
	String id1_id_no=multi.getParameter("id1_id_no");
	
	String id1year=multi.getParameter("id1year");
	String id1mon=multi.getParameter("id1mon");
	String id1date=multi.getParameter("id1date");
	//id issue date
	String id1_issue_date=id1year+"-"+id1mon+"-"+id1date;

	//second id
	String id2_type=multi.getParameter("id2_type");
	String id2_id_issued_at=multi.getParameter("id2_id_issued_at");
	String id2_id_no=multi.getParameter("id2_id_no");
	
	String id2year=multi.getParameter("id2year");
	String id2mon=multi.getParameter("id2mon");
	String id2date=multi.getParameter("id2date");
	//id issue date
	String id2_issue_date=id2year+"-"+id2mon+"-"+id2date;

	
	String photofilename=multi.getFilesystemName("photo");
	
	String photopath=null;
	String delphotopath=null;
	if(photofilename!=null)
	{
	photopath=filePath+"//"+photofilename;
	delphotopath="temp_images/"+photofilename;
	}
	
	String signfilename=multi.getFilesystemName("sign_image");
	String signpath=null;
	String delsignpath=null;
	if(signfilename!=null)
	{
	signpath=filePath+"//"+signfilename;
	delsignpath="temp_images/"+signfilename;
	}

		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("SELECT * FROM customer_info_table where cif_number=? and not cust_type='Nominee'" );
		stat.setString(1,introducer_cif);
		rs = stat.executeQuery();
		if(!rs.next())
		{
		//out.print("<h3><font color='#ff0000' face='Arial'>Product id already existed</font></h3>");
		msg="<h3><font color='#ff0000' face='Arial'>Introducer CIF Not existed</font></h3>";
		
		}
		else
		{
		//insert the first Identification
		PreparedStatement id1stat=conn.prepareStatement("insert into identification_details values(?,?,?,?,?)");
		String id1_id=branch+String.valueOf((int)(10000*Math.random()+1));
		id1stat.setString(1,id1_id);
		id1stat.setString(2,id1_type);
		id1stat.setString(3,id1_id_issued_at);
		id1stat.setString(4,id1_id_no);
		id1stat.setString(5,id1_issue_date);
		id1stat.executeUpdate();
		
		//Insert the second Identification
		PreparedStatement id2stat=conn.prepareStatement("insert into identification_details values(?,?,?,?,?)");
		String id2_id=branch+String.valueOf((int)(10000*Math.random()+1));
		id2stat.setString(1,id2_id);
		id2stat.setString(2,id2_type);
		id2stat.setString(3,id2_id_issued_at);
		id2stat.setString(4,id2_id_no);
		id2stat.setString(5,id2_issue_date);
		id2stat.executeUpdate();

				
		PreparedStatement stat1= conn.prepareStatement("insert into customer_info_table(cif_number,cust_type,first_name_business_name,relation,relation_name,dob_doe,address,city,state,pin_code,country,first_identification_id,second_identification_id,introducer_cif_number,tax_pan_no,email_id,branch_id,photo,sign_image) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		String cif_no=branch+String.valueOf((int)(10000*Math.random()+1));
		stat1.setString(1,cif_no);
		stat1.setString(2,cust_type);
		stat1.setString(3,company_name);
		stat1.setString(4,relation);
		stat1.setString(5,relation_name);
		stat1.setString(6,doe);
		stat1.setString(7,address);
		stat1.setString(8,city);
		stat1.setString(9,state);
		stat1.setString(10,pincode);
		stat1.setString(11,country);
		stat1.setString(12,id1_id);
		stat1.setString(13,id2_id);
		stat1.setString(14,introducer_cif);
		stat1.setString(15,pan_no);
		stat1.setString(16,emailid);
		stat1.setString(17,branch);
		
		
		
		File custphoto=new File(photopath);
		File custsign=new File(signpath);

		FileInputStream fisphoto=new FileInputStream(custphoto);
		FileInputStream fissign=new FileInputStream(custsign);

		stat1.setBinaryStream(18,(InputStream)fisphoto, (int)(custphoto.length()));
		stat1.setBinaryStream(19,(InputStream)fissign, (int)(custsign.length()));

		stat1.executeUpdate();
		//out.print("<h3><font color='#009933' face='Arial'>Non Personal CIF added successfully</font></h3>");
		msg="<h3><font color='#009933' face='Arial'>Non Personal CIF added successfully CIF NO : "+cif_no+"</font></h3>";
		boolean b=true;
		b=TheBean.dodelete(session,delphotopath);
		b=TheBean.dodelete(session,delsignpath);

		}
		
		}
		catch(Exception E)
		{
			//out.print("error inserting values:"+E);
			msg="error inserting values:"+E;
			
		}
		finally
		{
			rs.close();
			conn.close();
		}
		
	

    }//end of if
    }//end of try
	catch(Exception e)
	{
	//out.print("error Multi part data:"+e);
	msg="error Multi part data:"+e;
	
	}  


	return(msg);     
}//end of function createNonPersonalCIF


public String createPersonalCIF(HttpServletRequest request,HttpSession session, String branch)throws Exception 
{
	String msg="message";
    	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;

	try
	{  
	if(request.getContentType()!=null && request.getContentType()!="")
	{
	String serverPath = session.getServletContext().getRealPath("//");
    String filePath = serverPath + "//temp_images";
    MultipartRequest multi = new MultipartRequest(request, filePath, 1 * 1024 * 1024);
    
    String cust_type=multi.getParameter("cust_type");
	String title=multi.getParameter("title");
	String first_name=multi.getParameter("first_name");
	String middle_name=multi.getParameter("middle_name");
	String last_name=multi.getParameter("last_name");
	String relation=multi.getParameter("relation");
	String relation_name=multi.getParameter("relation_name");
	
	String year=multi.getParameter("year");
	String month=multi.getParameter("mon");
	String date=multi.getParameter("date");
	//date of birth
	String dob=year+"-"+month+"-"+date;
	
	String gender=multi.getParameter("gender");
	String address=multi.getParameter("address");
	String city=multi.getParameter("city");
	String pincode=multi.getParameter("pincode");
	String state=multi.getParameter("state");
	String country=multi.getParameter("country");
	String introducer_cif=multi.getParameter("introducer_cif");
	String pan_no=multi.getParameter("pan_no");
	String emailid=multi.getParameter("emailid");
	String source_of_funds=multi.getParameter("source_of_funds");
	String annual_income=multi.getParameter("annual_income");
	if(annual_income.equals(""))
	{
	annual_income="0.0";
	}
	String occupation=multi.getParameter("occupation");
	
	
	//first id
	String id1_type=multi.getParameter("id1_type");
	String id1_id_issued_at=multi.getParameter("id1_id_issued_at");
	String id1_id_no=multi.getParameter("id1_id_no");
	
	String id1year=multi.getParameter("id1year");
	String id1mon=multi.getParameter("id1mon");
	String id1date=multi.getParameter("id1date");
	//id issue date
	String id1_issue_date=id1year+"-"+id1mon+"-"+id1date;

	//second id
	String id2_type=multi.getParameter("id2_type");
	String id2_id_issued_at=multi.getParameter("id2_id_issued_at");
	String id2_id_no=multi.getParameter("id2_id_no");
	
	String id2year=multi.getParameter("id2year");
	String id2mon=multi.getParameter("id2mon");
	String id2date=multi.getParameter("id2date");
	//id issue date
	String id2_issue_date=id2year+"-"+id2mon+"-"+id2date;

	
	String photofilename=multi.getFilesystemName("photo");
	
	String photopath=null;
	String delphotopath=null;
	if(photofilename!=null)
	{
	photopath=filePath+"//"+photofilename;
	delphotopath="temp_images/"+photofilename;
	}
	
	String signfilename=multi.getFilesystemName("sign_image");
	String signpath=null;
	String delsignpath=null;
	if(signfilename!=null)
	{
	signpath=filePath+"//"+signfilename;
	delsignpath="temp_images/"+signfilename;
	}

		try
		{
		conn = bean.getConnection(request);
		PreparedStatement stat= conn.prepareStatement("SELECT * FROM customer_info_table where cif_number=? and not cust_type='Nominee'" );
		stat.setString(1,introducer_cif);
		rs = stat.executeQuery();
		if(!rs.next())
		{
		//out.print("<h3><font color='#ff0000' face='Arial'>Product id already existed</font></h3>");
		msg="<h3><font color='#ff0000' face='Arial'>Introducer CIF Not existed</font></h3>";
		
		}
		else
		{
		//insert the first Identification
		PreparedStatement id1stat=conn.prepareStatement("insert into identification_details values(?,?,?,?,?)");
		String id1_id=branch+String.valueOf((int)(10000*Math.random()+1));
		id1stat.setString(1,id1_id);
		id1stat.setString(2,id1_type);
		id1stat.setString(3,id1_id_issued_at);
		id1stat.setString(4,id1_id_no);
		id1stat.setString(5,id1_issue_date);
		id1stat.executeUpdate();
		
		//Insert the second Identification
		PreparedStatement id2stat=conn.prepareStatement("insert into identification_details values(?,?,?,?,?)");
		String id2_id=branch+String.valueOf((int)(10000*Math.random()+1));
		id2stat.setString(1,id2_id);
		id2stat.setString(2,id2_type);
		id2stat.setString(3,id2_id_issued_at);
		id2stat.setString(4,id2_id_no);
		id2stat.setString(5,id2_issue_date);
		id2stat.executeUpdate();

				
		PreparedStatement stat1= conn.prepareStatement("insert into customer_info_table values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		String cif_no=branch+String.valueOf((int)(10000*Math.random()+1));
		stat1.setString(1,cif_no);
		stat1.setString(2,cust_type);
		stat1.setString(3,title);
		stat1.setString(4,first_name);
		stat1.setString(5,middle_name);
		stat1.setString(6,last_name);
		stat1.setString(7,relation);
		stat1.setString(8,relation_name);
		stat1.setString(9,dob);
		stat1.setString(10,gender);
		stat1.setString(11,address);
		stat1.setString(12,city);
		stat1.setString(13,state);
		stat1.setString(14,pincode);
		stat1.setString(15,country);
		stat1.setString(16,id1_id);
		stat1.setString(17,id2_id);
		stat1.setString(18,introducer_cif);
		stat1.setString(19,pan_no);
		stat1.setString(20,emailid);
		stat1.setString(21,source_of_funds);
		stat1.setString(22,annual_income);
		stat1.setString(23,occupation);
		stat1.setString(24,branch);
		
		File custphoto=new File(photopath);
		File custsign=new File(signpath);

		FileInputStream fisphoto=new FileInputStream(custphoto);
		FileInputStream fissign=new FileInputStream(custsign);

		stat1.setBinaryStream(25,(InputStream)fisphoto, (int)(custphoto.length()));
		stat1.setBinaryStream(26,(InputStream)fissign, (int)(custsign.length()));

		stat1.executeUpdate();
		//out.print("<h3><font color='#009933' face='Arial'>Personal CIF added successfully</font></h3>");
		msg="<h3><font color='#009933' face='Arial'>Personal CIF added successfully CIF NO : "+cif_no+"</font></h3>";
		boolean b=true;
		b=TheBean.dodelete(session,delphotopath);
		b=TheBean.dodelete(session,delsignpath);

		}
		
		}
		catch(Exception E)
		{
			//out.print("error inserting values:"+E);
			msg="error inserting values:"+E;
			
		}
		finally
		{
			rs.close();
			conn.close();
		}
		
	

    }//end of if
    }//end of try
	catch(Exception e)
	{
	//out.print("error Multi part data:"+e);
	msg="error Multi part data:"+e;
	
	}       
return(msg);     


}//end of function createPersonalCIF

public String createNomineeCIF(HttpServletRequest request,HttpSession session, String branch)throws Exception 
{
	String msg="message";
    	Connection conn;
	conn=null;
	ResultSet rs;
	rs=null;
	
	String cust_type=request.getParameter("cust_type");
	String title=request.getParameter("title"); 
	String first_name=request.getParameter("first_name");
	String middle_name=request.getParameter("middle_name");
	String last_name=request.getParameter("last_name");
	String year=request.getParameter("year");
	String mon=request.getParameter("mon");
	String date=request.getParameter("date");
	String gender=request.getParameter("gender");
	String address=request.getParameter("address");
	String city=request.getParameter("city");
	String pincode=request.getParameter("pincode");
	String state=request.getParameter("state");
	String country=request.getParameter("country");
	String emailid=request.getParameter("emailid");
	String relation=request.getParameter("relation");
	
	
	String dob=year+"-"+mon+"-"+date;
	
	if((first_name!=null && first_name!=""))
	{
		try
		{
		conn = bean.getConnection(request);
		String cif_no=branch+String.valueOf((int)(10000*Math.random()+1));
		PreparedStatement stat1= conn.prepareStatement("insert into customer_info_table(cif_number,cust_type,title,first_name_business_name,middle_name,last_name,relation,dob_doe,gender,address,city,pin_code,state,country,email_id,branch_id) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
		stat1.setString(1,cif_no);
		stat1.setString(2,cust_type);
		stat1.setString(3,title);
		stat1.setString(4,first_name);
		stat1.setString(5,middle_name);
		stat1.setString(6,last_name);
		stat1.setString(7,relation);
		stat1.setString(8,dob);
		stat1.setString(9,gender);
		stat1.setString(10,address);
		stat1.setString(11,city);
		stat1.setString(12,pincode);
		stat1.setString(13,state);
		stat1.setString(14,country);
		stat1.setString(15,emailid);
		stat1.setString(16,branch);

		stat1.executeUpdate();
		//out.print("<h3><font color='#009933' face='Arial'>Nominee Successfully added CIF no :"+cif_no+"</font></h3>");
		msg="<h3><font color='red' face='Arial'>Nominee Successfully added CIF no :"+cif_no+"</font></h3>";
		}
		catch(Exception E)
		{
			//out.print("error inserting values:"+E);
			msg="error inserting values:"+E;
			
		}
		finally
		{
			conn.close();
		}
		
	}//end of if
	return(msg); 
} //end of function nominee   



}//end of class