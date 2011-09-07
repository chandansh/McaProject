<%@  page errorPage="errorpage.jsp" language="java"  import="java.sql.*,java.io.*"  %>

<jsp:useBean id="bean" class="com.cbs.CBSBean" scope="request"/>

<%      Blob image = null;
		Connection conn= null;
		byte[] imgData = null ;
		
		
		ResultSet rs = null;
	String cif_no_first_cust=request.getParameter("cif_no_first_cust");
		try {
			conn=bean.getConnection(request);
			PreparedStatement stmt = conn.prepareStatement("select sign_image from customer_info_table where cif_number=?");
			stmt.setString(1,cif_no_first_cust);
			rs= stmt.executeQuery();
			
			if (rs.next()) {
				image = rs.getBlob("sign_image");
				
					imgData = image.getBytes(1,(int)image.length());
				// display the image
       			  response.setContentType("image/gif");
       			  OutputStream o = response.getOutputStream();	
		         o.write(imgData);
    		     o.flush();
        		 o.close();
        
			} else {
				out.println("Display Blob Not found");
				out.println("image not found for given id");
				return;
			}

			
		} catch (Exception e) {
			out.println("Unable To Display image");
			out.println("Image Display Error=" + e.getMessage());
			return;
		} finally {
			try {
				rs.close();
				conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	%>