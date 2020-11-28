
<html>
<head>
	<script>
	function ValidateEmail(email) 
	{
	 if (/^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/.test(myForm.emailAddr.value))
	  {
	    return (true)
	  }
	    alert("You have entered an invalid email address!")
	    return (false)
	}

	</script>

</head>

<body>
  
<center> 
<h3>Form</h3>
<table> 

		<form action="server.jsp" method="post"> 
		
		<th>ID Number:</th><th><input type="int" name="id"/></th></tr> 
		<th>Email:</th><th><input type="email" name="email"/></th></tr>   
		<th><input type="submit" value="AddData"/></th>
		
		</form>

</table>


		<%
		
		HttpSession sess = request.getSession(false); //use false to use the existing session
			String msg= (String)sess.getAttribute("msg");
			if(msg==null)
			{
			out.print(" ");
			}else{
			out.print(msg);
			}
		%>

</center>

</body>

</html>