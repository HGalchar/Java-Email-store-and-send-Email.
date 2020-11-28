<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*,java.util.*,java.util.Date"%>
<%@ page import="javax.mail.*" %>
<%@ page import="javax.mail.internet.*, javax.activation.*" %>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>



<%
	String id_no=request.getParameter("id");
	int id=Integer.parseInt(id_no);
	String email=request.getParameter("email");
	
	

	

		try
		{
			
			
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/test", "root", "");
		Statement st=conn.createStatement();
		
	
		PreparedStatement ps = conn.prepareStatement("Select MailAddress from serverdata where MailAddress=?");
		ps.setString(1,email);
		
		ResultSet rs=ps.executeQuery();
				
				if(rs.next())
				{
					
					String Msg1="<center><h2>Mail address is already available!!!</h2></center>";
					HttpSession sess = request.getSession(); 
					sess.setAttribute("msg", Msg1);
					
					response.sendRedirect("index.jsp");
				}
				
				else{
					
				String sql="INSERT INTO `serverdata`(`ID Number`, `MailAddress`) VALUES ('"+id+"','"+email+"')";
				System.out.print("=====sql"+sql);
				
				int i=st.executeUpdate(sql);
				
					//mail sending code
					final String from = "testtatva180@gmail.com"; // change accordingly
			          final String password = "Tatva@2021#"; // change accordingly
			          String to = email; // change accordingly
			          String host = "smtp.gmail.com"; // or IP address
			
			          // Get system properties
			          Properties properties = System.getProperties();
			
			          // Setup mail server
			          properties.put("mail.smtp.host", host);
			          properties.put("mail.smtp.port", 587);
			          properties.put("mail.smtp.auth", "true");
			          properties.put("mail.smtp.starttls.enable", "true");
			          properties.put("mail.user", from);
			          properties.put("mail.password", password);
			
			          // Get the default Session object.
			          Authenticator auth = new Authenticator()
			          {
			              public PasswordAuthentication getPasswordAuthentication()
			              {
			                  return new PasswordAuthentication(from, password);
			              }
			          };
			          
			          Session ses = Session.getInstance(properties, auth);
			
			          try
			          {
			             // Create a default MimeMessage object.
			             MimeMessage message = new MimeMessage(ses);
			
			             // Set From: header field of the header.
			             message.setFrom(new InternetAddress(from));
			
			             // Set To: header field of the header.
			             message.addRecipient(Message.RecipientType.TO,new InternetAddress(to));
			
			             // Set Subject: header field
			             message.setSubject("WELCOME TO BELIEVER");
			
			             // Now set the actual message
			             
			             MimeBodyPart messageBodyPart = new MimeBodyPart();

				         // Fill the message
				         messageBodyPart.setText("Hello,"+email+"  " + "I am from Believer.\n");
			             // Create a multipar message
				         Multipart multipart = new MimeMultipart();
					
				         // Set text message part
				         multipart.addBodyPart(messageBodyPart);
				
				         // Part two is attachment
				         messageBodyPart = new MimeBodyPart();
				         String filename = "E:/Projects/eclipse projects/Believer/src/main/webapp/welcome.html";
				         DataSource source = new FileDataSource(filename);
				         messageBodyPart.setDataHandler(new DataHandler(source));
				         messageBodyPart.setFileName(filename);
				         multipart.addBodyPart(messageBodyPart);
						
				         
				         MimeBodyPart htmlPart = new MimeBodyPart();
				         String html ="<html>";
				            html+="<h3>You have successfully Registered!!</h>";
				            html+="</html>";
	         				

				         	 
				
								         
						 htmlPart.setContent(html, "text/html; charset=utf-8");
				         multipart.addBodyPart(htmlPart);
				         
				         // Send the complete message parts
				         
				         message.setContent(multipart );
				         message.setSentDate(new Date());

			
			             // Send message
			             Transport.send(message);
			             System.out.println("Sent message successfully....");
			          }
			          catch (SendFailedException mex)
			          {
			             mex.printStackTrace();
			          }
					
				    String Msg2="<center><h2>Data is successfully inserted!</h2></center>";
				    HttpSession sess = request.getSession(); 
					sess.setAttribute("msg", Msg2);
				
					
				response.sendRedirect("index.jsp");
				    
				    
				}
	}

		
		catch(Exception e)
		{
			String msg="sorry data has not stored!!";
			out.println(msg);
			System.out.print(e);
			e.printStackTrace();
		}


%>





